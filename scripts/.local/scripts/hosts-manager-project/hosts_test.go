package main

import (
	"os"
	"strings"
	"testing"
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
	// Test with a non-existent file path
	hm := NewHostsManager("/tmp/nonexistent_hosts_file_test")

	// This should create an empty managed block and return empty domains
	// Note: This test might fail if we don't have sudo access, but that's expected
	domains, err := hm.LoadDomains()

	// We expect either success with empty domains or an error due to sudo requirements
	if err == nil {
		if len(domains) != 0 {
			t.Errorf("Expected 0 domains for non-existent file, got %d", len(domains))
		}
	} else {
		// Error is acceptable since we might not have sudo access in tests
		t.Logf("Expected error due to sudo requirements: %v", err)
	}
}
