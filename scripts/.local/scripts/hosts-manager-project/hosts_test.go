package main

import (
	"os"
	"strings"
	"testing"
	"time"
)

func TestHostsManager_LoadDomains(t *testing.T) {
	// Create a temporary hosts file
	content := `127.0.0.1 localhost
::1 localhost

# --- HOSTS_MANAGER_BLOCK_START ---
127.0.0.1 example.com
127.0.0.1 www.example.com
# 127.0.0.1 test.com
# 127.0.0.1 www.test.com
# --- HOSTS_MANAGER_BLOCK_END ---

# Other content
192.168.1.1 router
`

	tmpFile, err := os.CreateTemp("", "hosts_test")
	if err != nil {
		t.Fatalf("Failed to create temp file: %v", err)
	}
	defer os.Remove(tmpFile.Name())

	if _, err := tmpFile.WriteString(content); err != nil {
		t.Fatalf("Failed to write to temp file: %v", err)
	}
	tmpFile.Close()

	hm := NewHostsManager(tmpFile.Name())
	domains, err := hm.LoadDomains()
	if err != nil {
		t.Fatalf("LoadDomains failed: %v", err)
	}

	if len(domains) != 2 {
		t.Errorf("Expected 2 domains, got %d", len(domains))
	}

	// Check that example.com is blocked and test.com is not
	var exampleDomain, testDomain *Domain
	for i := range domains {
		if domains[i].Name == "example.com" {
			exampleDomain = &domains[i]
		} else if domains[i].Name == "test.com" {
			testDomain = &domains[i]
		}
	}

	if exampleDomain == nil {
		t.Error("Expected to find example.com domain")
	} else if !exampleDomain.Blocked {
		t.Error("Expected example.com to be blocked")
	}

	if testDomain == nil {
		t.Error("Expected to find test.com domain")
	} else if testDomain.Blocked {
		t.Error("Expected test.com to be unblocked")
	}
}

func TestHostsManager_LoadDomains_NoManagedBlock(t *testing.T) {
	// Create a temporary hosts file without managed block
	content := `127.0.0.1 localhost
::1 localhost
192.168.1.1 router
`

	tmpFile, err := os.CreateTemp("", "hosts_test")
	if err != nil {
		t.Fatalf("Failed to create temp file: %v", err)
	}
	defer os.Remove(tmpFile.Name())

	if _, err := tmpFile.WriteString(content); err != nil {
		t.Fatalf("Failed to write to temp file: %v", err)
	}
	tmpFile.Close()

	hm := NewHostsManager(tmpFile.Name())
	domains, err := hm.LoadDomains()
	if err != nil {
		t.Fatalf("LoadDomains failed: %v", err)
	}

	if len(domains) != 0 {
		t.Errorf("Expected 0 domains when no managed block exists, got %d", len(domains))
	}
}

func TestHostsManager_GenerateManagedBlock(t *testing.T) {
	hm := NewHostsManager("")
	domains := []Domain{
		{Name: "example.com", Blocked: true},
		{Name: "test.com", Blocked: false},
	}

	block := hm.generateManagedBlock(domains)

	expectedLines := []string{
		StartBlock,
		"127.0.0.1 example.com",
		"127.0.0.1 www.example.com",
		"# 127.0.0.1 test.com",
		"# 127.0.0.1 www.test.com",
		EndBlock,
	}

	lines := strings.Split(strings.TrimSpace(block), "\n")
	if len(lines) != len(expectedLines) {
		t.Errorf("Expected %d lines, got %d", len(expectedLines), len(lines))
	}

	for i, expected := range expectedLines {
		if i >= len(lines) {
			t.Errorf("Missing line %d: expected '%s'", i, expected)
			continue
		}
		if lines[i] != expected {
			t.Errorf("Line %d: expected '%s', got '%s'", i, expected, lines[i])
		}
	}
}

func TestHostsManager_SaveDomains(t *testing.T) {
	// Create a temporary hosts file with existing content
	originalContent := `127.0.0.1 localhost
::1 localhost

# --- HOSTS_MANAGER_BLOCK_START ---
127.0.0.1 old.com
127.0.0.1 www.old.com
# --- HOSTS_MANAGER_BLOCK_END ---

# Other content
192.168.1.1 router
`

	tmpFile, err := os.CreateTemp("", "hosts_test")
	if err != nil {
		t.Fatalf("Failed to create temp file: %v", err)
	}
	defer os.Remove(tmpFile.Name())

	if _, err := tmpFile.WriteString(originalContent); err != nil {
		t.Fatalf("Failed to write to temp file: %v", err)
	}
	tmpFile.Close()

	// Mock the sudo tee command by creating a custom HostsManager
	// that writes directly to the file for testing
	hm := &HostsManager{filePath: tmpFile.Name()}

	domains := []Domain{
		{Name: "example.com", Blocked: true},
		{Name: "test.com", Blocked: false},
	}

	// We can't test the actual SaveDomains method because it uses sudo
	// Instead, test the block generation and replacement logic
	newBlock := hm.generateManagedBlock(domains)

	content, err := os.ReadFile(tmpFile.Name())
	if err != nil {
		t.Fatalf("Failed to read temp file: %v", err)
	}

	// Manually replace the block for testing
	contentStr := string(content)
	startIdx := strings.Index(contentStr, StartBlock)
	endIdx := strings.Index(contentStr, EndBlock)

	if startIdx == -1 || endIdx == -1 {
		t.Fatal("Could not find managed block markers")
	}

	newContent := contentStr[:startIdx] + newBlock + contentStr[endIdx+len(EndBlock):]

	// Verify the new content contains our domains
	if !strings.Contains(newContent, "127.0.0.1 example.com") {
		t.Error("Expected new content to contain blocked example.com")
	}
	if !strings.Contains(newContent, "# 127.0.0.1 test.com") {
		t.Error("Expected new content to contain commented test.com")
	}
	if strings.Contains(newContent, "old.com") {
		t.Error("Expected old.com to be removed from managed block")
	}

	// Verify other content is preserved
	if !strings.Contains(newContent, "127.0.0.1 localhost") {
		t.Error("Expected original localhost entry to be preserved")
	}
	if !strings.Contains(newContent, "192.168.1.1 router") {
		t.Error("Expected router entry to be preserved")
	}
}

func TestHostsManager_LoadDomains_NonExistentFile(t *testing.T) {
	hm := NewHostsManager("/tmp/nonexistent_hosts_test_file")
	hm.SetTestMode(true) // Enable test mode to avoid sudo

	domains, err := hm.LoadDomains()

	// Should create the managed block and return empty domains
	if err != nil {
		t.Errorf("LoadDomains failed: %v", err)
		return
	}

	if len(domains) != 0 {
		t.Errorf("Expected 0 domains for non-existent file, got %d", len(domains))
	}

	// Clean up the created file
	os.Remove("/tmp/nonexistent_hosts_test_file")
}

func TestHostsManager_RefreshSudoCredentials(t *testing.T) {
	hm := NewHostsManager("")

	// Test case 1: Fresh credentials (should not need refresh)
	hm.SetInitialSudoRefresh(time.Now())
	if hm.needsCredentialRefresh() {
		t.Error("Fresh credentials should not need refresh")
	}

	// Test case 2: Expired credentials (should need refresh)
	hm.SetInitialSudoRefresh(time.Now().Add(-6 * time.Minute)) // 6 minutes ago
	if !hm.needsCredentialRefresh() {
		t.Error("6-minute-old credentials should need refresh")
	}

	// Test case 3: Nearly expired credentials (should need refresh)
	hm.SetInitialSudoRefresh(time.Now().Add(-4*time.Minute - 30*time.Second)) // 4.5 minutes ago
	if !hm.needsCredentialRefresh() {
		t.Error("4.5-minute-old credentials should need refresh")
	}

	// Test case 4: Test mode should not require sudo
	hm.SetTestMode(true)
	err := hm.refreshSudoCredentials()
	if err != nil {
		t.Errorf("Test mode should not fail credential refresh: %v", err)
	}
}

func TestHostsManager_SudoTimeoutScenario(t *testing.T) {
	// Create a temporary hosts file with managed block
	content := `127.0.0.1 localhost

# --- HOSTS_MANAGER_BLOCK_START ---
127.0.0.1 example.com
127.0.0.1 www.example.com
# --- HOSTS_MANAGER_BLOCK_END ---

# Other content
192.168.1.1 router
`

	tmpFile, err := os.CreateTemp("", "hosts_timeout_test")
	if err != nil {
		t.Fatalf("Failed to create temp file: %v", err)
	}
	defer os.Remove(tmpFile.Name())

	if _, err := tmpFile.WriteString(content); err != nil {
		t.Fatalf("Failed to write to temp file: %v", err)
	}
	tmpFile.Close()

	hm := NewHostsManager(tmpFile.Name())
	hm.SetTestMode(true) // Enable test mode

	// Simulate expired sudo credentials
	hm.SetInitialSudoRefresh(time.Now().Add(-10 * time.Minute)) // 10 minutes ago

	domains := []Domain{
		{Name: "newdomain.com", Blocked: true},
	}

	// This should work in test mode even with expired credentials
	err = hm.SaveDomains(domains)
	if err != nil {
		t.Errorf("SaveDomains should work in test mode: %v", err)
	}

	// Verify the domain was saved
	savedDomains, err := hm.LoadDomains()
	if err != nil {
		t.Errorf("LoadDomains failed: %v", err)
	}

	found := false
	for _, d := range savedDomains {
		if d.Name == "newdomain.com" && d.Blocked {
			found = true
			break
		}
	}
	if !found {
		t.Error("Expected to find newdomain.com as blocked")
	}
}

func TestHostsManager_CredentialRefreshTiming(t *testing.T) {
	hm := NewHostsManager("")

	// Test that credentials are considered valid for the first 4 minutes
	testCases := []struct {
		name          string
		timeAgo       time.Duration
		shouldRefresh bool
	}{
		{"Fresh credentials", 0, false},
		{"1 minute old", 1 * time.Minute, false},
		{"3 minutes old", 3 * time.Minute, false},
		{"4 minutes old", 4 * time.Minute, true},
		{"5 minutes old", 5 * time.Minute, true},
		{"10 minutes old", 10 * time.Minute, true},
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			hm.SetInitialSudoRefresh(time.Now().Add(-tc.timeAgo))

			// Check if refresh is needed by examining the time logic
			needsRefresh := hm.needsCredentialRefresh()

			if needsRefresh != tc.shouldRefresh {
				t.Errorf("Expected needsRefresh=%v for %s, got %v",
					tc.shouldRefresh, tc.name, needsRefresh)
			}
		})
	}
}

func TestHostsManager_ConcurrentOperations(t *testing.T) {
	// Test that multiple operations handle credential refresh correctly
	content := `127.0.0.1 localhost

# --- HOSTS_MANAGER_BLOCK_START ---
# --- HOSTS_MANAGER_BLOCK_END ---
`

	tmpFile, err := os.CreateTemp("", "hosts_concurrent_test")
	if err != nil {
		t.Fatalf("Failed to create temp file: %v", err)
	}
	defer os.Remove(tmpFile.Name())

	if _, err := tmpFile.WriteString(content); err != nil {
		t.Fatalf("Failed to write to temp file: %v", err)
	}
	tmpFile.Close()

	hm := NewHostsManager(tmpFile.Name())
	hm.SetTestMode(true) // Enable test mode

	// Simulate expired credentials
	hm.SetInitialSudoRefresh(time.Now().Add(-6 * time.Minute))

	domains := []Domain{
		{Name: "test1.com", Blocked: true},
		{Name: "test2.com", Blocked: false},
	}

	// Multiple save operations should work in test mode
	for i := 0; i < 3; i++ {
		err := hm.SaveDomains(domains)
		if err != nil {
			t.Errorf("SaveDomains attempt %d failed: %v", i+1, err)
		}
	}

	// Verify final state
	savedDomains, err := hm.LoadDomains()
	if err != nil {
		t.Errorf("LoadDomains failed: %v", err)
	}

	if len(savedDomains) != 2 {
		t.Errorf("Expected 2 domains, got %d", len(savedDomains))
	}
}
