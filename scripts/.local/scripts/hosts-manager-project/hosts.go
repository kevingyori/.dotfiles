package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

const (
	DefaultHostsFile = "/etc/hosts"
	StartBlock       = "# --- HOSTS_MANAGER_BLOCK_START ---"
	EndBlock         = "# --- HOSTS_MANAGER_BLOCK_END ---"
	IPToBlock        = "127.0.0.1"
)

// HostsManager handles reading and writing to the hosts file
type HostsManager struct {
	filePath string
}

// NewHostsManager creates a new hosts manager
func NewHostsManager(filePath string) *HostsManager {
	if filePath == "" {
		filePath = DefaultHostsFile
	}
	return &HostsManager{
		filePath: filePath,
	}
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
	content := fmt.Sprintf("\n%s\n%s\n", StartBlock, EndBlock)
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
	// macOS DNS cache flush commands
	exec.Command("sudo", "dscacheutil", "-flushcache").Run()
	exec.Command("sudo", "killall", "-HUP", "mDNSResponder").Run()
}
