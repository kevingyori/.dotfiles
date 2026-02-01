package main

import (
	"fmt"
	"os"
	"time"
)

// This is a demonstration of how the timeout scenario would work
// Run this with: go run timeout_test.go
func main() {
	fmt.Println("=== Hosts Manager Sudo Timeout Demonstration ===")

	// Create a temporary hosts file for testing
	tmpFile, err := os.CreateTemp("", "hosts_timeout_demo")
	if err != nil {
		fmt.Printf("Failed to create temp file: %v\n", err)
		return
	}
	defer os.Remove(tmpFile.Name())

	// Write initial content
	initialContent := `127.0.0.1 localhost

# --- HOSTS_MANAGER_BLOCK_START ---
127.0.0.1 example.com
127.0.0.1 www.example.com
# --- HOSTS_MANAGER_BLOCK_END ---

# Other content
192.168.1.1 router
`
	tmpFile.WriteString(initialContent)
	tmpFile.Close()

	fmt.Printf("Created test hosts file: %s\n", tmpFile.Name())

	// Create hosts manager
	hm := NewHostsManager(tmpFile.Name())
	hm.SetTestMode(true) // Use test mode for demonstration

	// Scenario 1: Fresh credentials (should work without refresh)
	fmt.Println("\n--- Scenario 1: Fresh credentials ---")
	hm.SetInitialSudoRefresh(time.Now())
	fmt.Printf("Credentials age: %v\n", time.Since(hm.lastSudoRefresh))
	fmt.Printf("Needs refresh: %v\n", hm.needsCredentialRefresh())

	domains := []Domain{{Name: "fresh-test.com", Blocked: true}}
	err = hm.SaveDomains(domains)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	} else {
		fmt.Println("✓ Save successful with fresh credentials")
	}

	// Scenario 2: Expired credentials (should trigger refresh)
	fmt.Println("\n--- Scenario 2: Expired credentials (6 minutes old) ---")
	hm.SetInitialSudoRefresh(time.Now().Add(-6 * time.Minute))
	fmt.Printf("Credentials age: %v\n", time.Since(hm.lastSudoRefresh))
	fmt.Printf("Needs refresh: %v\n", hm.needsCredentialRefresh())

	domains = []Domain{{Name: "expired-test.com", Blocked: true}}
	err = hm.SaveDomains(domains)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	} else {
		fmt.Println("✓ Save successful after credential refresh")
	}

	// Scenario 3: Nearly expired credentials (should trigger refresh)
	fmt.Println("\n--- Scenario 3: Nearly expired credentials (4.5 minutes old) ---")
	hm.SetInitialSudoRefresh(time.Now().Add(-4*time.Minute - 30*time.Second))
	fmt.Printf("Credentials age: %v\n", time.Since(hm.lastSudoRefresh))
	fmt.Printf("Needs refresh: %v\n", hm.needsCredentialRefresh())

	domains = []Domain{{Name: "nearly-expired-test.com", Blocked: true}}
	err = hm.SaveDomains(domains)
	if err != nil {
		fmt.Printf("Error: %v\n", err)
	} else {
		fmt.Println("✓ Save successful after proactive credential refresh")
	}

	// Show final state
	fmt.Println("\n--- Final hosts file state ---")
	finalDomains, err := hm.LoadDomains()
	if err != nil {
		fmt.Printf("Error loading domains: %v\n", err)
		return
	}

	fmt.Printf("Total domains managed: %d\n", len(finalDomains))
	for _, d := range finalDomains {
		status := "unblocked"
		if d.Blocked {
			status = "blocked"
		}
		fmt.Printf("  - %s: %s\n", d.Name, status)
	}

	fmt.Println("\n=== Demonstration Complete ===")
	fmt.Println("The fix prevents the application from freezing by:")
	fmt.Println("1. Tracking when sudo credentials were last refreshed")
	fmt.Println("2. Proactively refreshing credentials before they expire")
	fmt.Println("3. Handling credential refresh failures gracefully")
	fmt.Println("4. Using test mode to avoid sudo operations during testing")
}
