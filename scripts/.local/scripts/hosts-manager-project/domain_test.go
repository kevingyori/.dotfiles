package main

import (
	"testing"
)

func TestDomainList_Add(t *testing.T) {
	dl := NewDomainList()

	// Test adding a new domain
	dl.Add("example.com")
	domains := dl.Get()
	if len(domains) != 1 {
		t.Errorf("Expected 1 domain, got %d", len(domains))
	}
	if domains[0].Name != "example.com" {
		t.Errorf("Expected domain name 'example.com', got '%s'", domains[0].Name)
	}
	if domains[0].Blocked {
		t.Error("Expected new domain to be unblocked")
	}

	// Test adding duplicate domain
	dl.Add("example.com")
	domains = dl.Get()
	if len(domains) != 1 {
		t.Errorf("Expected 1 domain after adding duplicate, got %d", len(domains))
	}

	// Test domain normalization
	dl.Add("  EXAMPLE.COM  ")
	domains = dl.Get()
	if len(domains) != 1 {
		t.Errorf("Expected 1 domain after adding normalized duplicate, got %d", len(domains))
	}

	// Test www prefix removal
	dl.Add("www.test.com")
	domains = dl.Get()
	if len(domains) != 2 {
		t.Errorf("Expected 2 domains, got %d", len(domains))
	}
	// Find the test.com domain
	found := false
	for _, d := range domains {
		if d.Name == "test.com" {
			found = true
			break
		}
	}
	if !found {
		t.Error("Expected www.test.com to be normalized to test.com")
	}
}

func TestDomainList_Remove(t *testing.T) {
	dl := NewDomainList()
	dl.Add("example.com")
	dl.Add("test.com")

	// Test removing existing domain
	removed := dl.Remove("example.com")
	if !removed {
		t.Error("Expected Remove to return true for existing domain")
	}
	domains := dl.Get()
	if len(domains) != 1 {
		t.Errorf("Expected 1 domain after removal, got %d", len(domains))
	}
	if domains[0].Name != "test.com" {
		t.Errorf("Expected remaining domain to be 'test.com', got '%s'", domains[0].Name)
	}

	// Test removing non-existing domain
	removed = dl.Remove("nonexistent.com")
	if removed {
		t.Error("Expected Remove to return false for non-existing domain")
	}
	domains = dl.Get()
	if len(domains) != 1 {
		t.Errorf("Expected 1 domain after failed removal, got %d", len(domains))
	}
}

func TestDomainList_Toggle(t *testing.T) {
	dl := NewDomainList()
	dl.Add("example.com")

	// Test toggling existing domain
	toggled := dl.Toggle("example.com")
	if !toggled {
		t.Error("Expected Toggle to return true for existing domain")
	}
	domains := dl.Get()
	if !domains[0].Blocked {
		t.Error("Expected domain to be blocked after toggle")
	}

	// Test toggling again
	toggled = dl.Toggle("example.com")
	if !toggled {
		t.Error("Expected Toggle to return true for existing domain")
	}
	domains = dl.Get()
	if domains[0].Blocked {
		t.Error("Expected domain to be unblocked after second toggle")
	}

	// Test toggling non-existing domain
	toggled = dl.Toggle("nonexistent.com")
	if toggled {
		t.Error("Expected Toggle to return false for non-existing domain")
	}
}

func TestDomainList_Filter(t *testing.T) {
	dl := NewDomainList()
	dl.Add("example.com")
	dl.Add("test.com")
	dl.Add("google.com")
	dl.Add("facebook.com")

	// Test empty query returns all
	filtered := dl.Filter("")
	if len(filtered) != 4 {
		t.Errorf("Expected 4 domains for empty query, got %d", len(filtered))
	}

	// Test partial match
	filtered = dl.Filter("com")
	if len(filtered) != 4 {
		t.Errorf("Expected 4 domains for 'com' query, got %d", len(filtered))
	}

	// Test specific match
	filtered = dl.Filter("example")
	if len(filtered) != 1 {
		t.Errorf("Expected 1 domain for 'example' query, got %d", len(filtered))
	}
	if filtered[0].Name != "example.com" {
		t.Errorf("Expected 'example.com', got '%s'", filtered[0].Name)
	}

	// Test case insensitive
	filtered = dl.Filter("GOOGLE")
	if len(filtered) != 1 {
		t.Errorf("Expected 1 domain for 'GOOGLE' query, got %d", len(filtered))
	}
	if filtered[0].Name != "google.com" {
		t.Errorf("Expected 'google.com', got '%s'", filtered[0].Name)
	}

	// Test no matches
	filtered = dl.Filter("nonexistent")
	if len(filtered) != 0 {
		t.Errorf("Expected 0 domains for 'nonexistent' query, got %d", len(filtered))
	}
}

func TestDomainList_Set(t *testing.T) {
	dl := NewDomainList()

	domains := []Domain{
		{Name: "example.com", Blocked: true},
		{Name: "test.com", Blocked: false},
	}

	dl.Set(domains)
	result := dl.Get()

	if len(result) != 2 {
		t.Errorf("Expected 2 domains after Set, got %d", len(result))
	}

	// Check sorting (example.com should come before test.com)
	if result[0].Name != "example.com" {
		t.Errorf("Expected first domain to be 'example.com', got '%s'", result[0].Name)
	}
	if !result[0].Blocked {
		t.Error("Expected first domain to be blocked")
	}
	if result[1].Name != "test.com" {
		t.Errorf("Expected second domain to be 'test.com', got '%s'", result[1].Name)
	}
	if result[1].Blocked {
		t.Error("Expected second domain to be unblocked")
	}
}

func TestDomainList_Count(t *testing.T) {
	dl := NewDomainList()

	if dl.Count() != 0 {
		t.Errorf("Expected 0 domains in new list, got %d", dl.Count())
	}

	dl.Add("example.com")
	if dl.Count() != 1 {
		t.Errorf("Expected 1 domain after adding, got %d", dl.Count())
	}

	dl.Add("test.com")
	if dl.Count() != 2 {
		t.Errorf("Expected 2 domains after adding second, got %d", dl.Count())
	}

	dl.Remove("example.com")
	if dl.Count() != 1 {
		t.Errorf("Expected 1 domain after removing, got %d", dl.Count())
	}
}
