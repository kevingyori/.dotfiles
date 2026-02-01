package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"strings"
	"time"
)

const (
	DefaultHostsFile = "/etc/hosts"
	StartBlock       = "# --- HOSTS_MANAGER_BLOCK_START ---"
	EndBlock         = "# --- HOSTS_MANAGER_BLOCK_END ---"
	IPToBlock        = "127.0.0.1"
	SudoTimeout      = 5 * time.Minute // Default sudo timeout
)

// HostsManager handles reading and writing to the hosts file
type HostsManager struct {
	filePath        string
	lastSudoRefresh time.Time
	testMode        bool // For testing without sudo
}

// NewHostsManager creates a new hosts manager
func NewHostsManager(filePath string) *HostsManager {
	if filePath == "" {
		filePath = DefaultHostsFile
	}
	return &HostsManager{
		filePath: filePath,
		testMode: false,
	}
}

// SetTestMode enables test mode to avoid sudo operations
func (hm *HostsManager) SetTestMode(enabled bool) {
	hm.testMode = enabled
}

// SetInitialSudoRefresh sets the initial sudo refresh time
func (hm *HostsManager) SetInitialSudoRefresh(t time.Time) {
	hm.lastSudoRefresh = t
}

// refreshSudoCredentials refreshes sudo credentials if needed
func (hm *HostsManager) refreshSudoCredentials() error {
	// Skip sudo operations in test mode
	if hm.testMode {
		return nil
	}

	// Check if we need to refresh (if more than 4 minutes have passed since last refresh)
	if time.Since(hm.lastSudoRefresh) < SudoTimeout-time.Minute {
		return nil // Still valid
	}

	// Try to refresh sudo credentials
	cmd := exec.Command("sudo", "-n", "-v")
	if err := cmd.Run(); err != nil {
		// Credentials expired, need interactive refresh
		fmt.Println("Sudo credentials expired. Please re-enter your password:")
		cmd = exec.Command("sudo", "-v")
		cmd.Stdin = os.Stdin
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			return fmt.Errorf("failed to refresh sudo credentials: %w", err)
		}
	}

	hm.lastSudoRefresh = time.Now()
	return nil
}

// needsCredentialRefresh returns true if credentials need to be refreshed
func (hm *HostsManager) needsCredentialRefresh() bool {
	return time.Since(hm.lastSudoRefresh) >= SudoTimeout-time.Minute
}

// LoadDomains reads domains from the hosts file
func (hm *HostsManager) LoadDomains() ([]Domain, error) {
	file, err := os.Open(hm.filePath)
	if err != nil {
		if os.IsNotExist(err) {
			// Create the managed block if file doesn't exist
			if err := hm.createManagedBlock(); err != nil {
				return nil, fmt.Errorf("failed to create hosts block: %w", err)
			}
			return []Domain{}, nil
		}
		return nil, fmt.Errorf("failed to open hosts file: %w", err)
	}
	defer file.Close()

	managedDomains := make(map[string]bool)
	inBlock := false
	scanner := bufio.NewScanner(file)

	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())

		if line == StartBlock {
			inBlock = true
			continue
		}
		if line == EndBlock {
			inBlock = false
			continue
		}

		if inBlock {
			isCommented := strings.HasPrefix(line, "#")
			if isCommented {
				line = strings.TrimSpace(strings.TrimPrefix(line, "#"))
			}

			parts := strings.Fields(line)
			if len(parts) == 2 && parts[0] == IPToBlock {
				domainName := strings.TrimPrefix(parts[1], "www.")
				if !isCommented {
					managedDomains[domainName] = true
				} else if _, exists := managedDomains[domainName]; !exists {
					managedDomains[domainName] = false
				}
			}
		}
	}

	if err := scanner.Err(); err != nil {
		return nil, fmt.Errorf("error reading hosts file: %w", err)
	}

	var domains []Domain
	for name, blocked := range managedDomains {
		domains = append(domains, Domain{Name: name, Blocked: blocked})
	}

	return domains, nil
}

// SaveDomains writes domains to the hosts file
func (hm *HostsManager) SaveDomains(domains []Domain) error {
	// Refresh sudo credentials before performing operations that require sudo
	if err := hm.refreshSudoCredentials(); err != nil {
		return fmt.Errorf("failed to refresh sudo credentials: %w", err)
	}

	newBlock := hm.generateManagedBlock(domains)

	content, err := os.ReadFile(hm.filePath)
	if err != nil {
		return fmt.Errorf("failed to read hosts file: %w", err)
	}

	startIndex := bytes.Index(content, []byte(StartBlock))
	endIndex := bytes.Index(content, []byte(EndBlock))
	if startIndex == -1 || endIndex == -1 {
		return fmt.Errorf("management block not found in hosts file")
	}

	var finalContent bytes.Buffer
	finalContent.Write(content[:startIndex])
	finalContent.WriteString(newBlock)
	finalContent.Write(content[endIndex+len(EndBlock):])

	if err := hm.writeToFile(finalContent.Bytes()); err != nil {
		return fmt.Errorf("failed to write hosts file: %w", err)
	}

	// Flush DNS cache
	hm.flushDNSCache()

	return nil
}

// createManagedBlock creates the initial managed block in the hosts file
func (hm *HostsManager) createManagedBlock() error {
	// Refresh sudo credentials before performing operations that require sudo
	if err := hm.refreshSudoCredentials(); err != nil {
		return fmt.Errorf("failed to refresh sudo credentials: %w", err)
	}

	content := fmt.Sprintf("\n%s\n%s\n", StartBlock, EndBlock)

	// In test mode, write directly to file without sudo
	if hm.testMode {
		file, err := os.OpenFile(hm.filePath, os.O_APPEND|os.O_WRONLY|os.O_CREATE, 0644)
		if err != nil {
			return fmt.Errorf("failed to open file in test mode: %w", err)
		}
		defer file.Close()

		_, err = file.WriteString(content)
		return err
	}

	cmd := exec.Command("sudo", "tee", "-a", hm.filePath)
	cmd.Stdin = strings.NewReader(content)
	return cmd.Run()
}

// generateManagedBlock creates the content for the managed block
func (hm *HostsManager) generateManagedBlock(domains []Domain) string {
	var block strings.Builder
	block.WriteString(StartBlock + "\n")

	for _, d := range domains {
		if d.Blocked {
			block.WriteString(fmt.Sprintf("%s %s\n", IPToBlock, d.Name))
			block.WriteString(fmt.Sprintf("%s www.%s\n", IPToBlock, d.Name))
		} else {
			block.WriteString(fmt.Sprintf("# %s %s\n", IPToBlock, d.Name))
			block.WriteString(fmt.Sprintf("# %s www.%s\n", IPToBlock, d.Name))
		}
	}

	block.WriteString(EndBlock)
	return block.String()
}

// writeToFile writes content to the hosts file using sudo
func (hm *HostsManager) writeToFile(content []byte) error {
	// In test mode, write directly to file without sudo
	if hm.testMode {
		return os.WriteFile(hm.filePath, content, 0644)
	}

	cmd := exec.Command("sudo", "tee", hm.filePath)
	cmd.Stdin = bytes.NewReader(content)

	var stderr bytes.Buffer
	cmd.Stderr = &stderr

	if err := cmd.Run(); err != nil {
		return fmt.Errorf("write failed: %s", stderr.String())
	}

	return nil
}

// flushDNSCache flushes the system DNS cache
func (hm *HostsManager) flushDNSCache() {
	// Skip DNS cache flushing in test mode
	if hm.testMode {
		return
	}

	// macOS DNS cache flush commands
	exec.Command("sudo", "dscacheutil", "-flushcache").Run()
	exec.Command("sudo", "killall", "-HUP", "mDNSResponder").Run()
}
