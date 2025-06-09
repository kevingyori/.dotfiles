package main

import (
	"sort"
	"strings"
)

// Domain represents a domain entry with its blocking status
type Domain struct {
	Name    string `json:"name"`
	Blocked bool   `json:"blocked"`
}

// DomainList manages a collection of domains
type DomainList struct {
	domains []Domain
}

// NewDomainList creates a new domain list
func NewDomainList() *DomainList {
	return &DomainList{
		domains: make([]Domain, 0),
	}
}

// Add adds a new domain to the list
func (dl *DomainList) Add(name string) {
	// Normalize domain name
	name = strings.ToLower(strings.TrimSpace(name))
	name = strings.TrimPrefix(name, "www.")

	// Check if domain already exists
	for _, d := range dl.domains {
		if d.Name == name {
			// Domain exists, don't add duplicate
			return
		}
	}

	dl.domains = append(dl.domains, Domain{
		Name:    name,
		Blocked: false,
	})
	dl.sort()
}

// Remove removes a domain from the list
func (dl *DomainList) Remove(name string) bool {
	for i, d := range dl.domains {
		if d.Name == name {
			dl.domains = append(dl.domains[:i], dl.domains[i+1:]...)
			return true
		}
	}
	return false
}

// Toggle toggles the blocking status of a domain
func (dl *DomainList) Toggle(name string) bool {
	for i, d := range dl.domains {
		if d.Name == name {
			dl.domains[i].Blocked = !dl.domains[i].Blocked
			return true
		}
	}
	return false
}

// Get returns a copy of all domains
func (dl *DomainList) Get() []Domain {
	result := make([]Domain, len(dl.domains))
	copy(result, dl.domains)
	return result
}

// Set replaces all domains with the provided list
func (dl *DomainList) Set(domains []Domain) {
	dl.domains = make([]Domain, len(domains))
	copy(dl.domains, domains)
	dl.sort()
}

// Filter returns domains matching the search query
func (dl *DomainList) Filter(query string) []Domain {
	if query == "" {
		return dl.Get()
	}

	query = strings.ToLower(strings.TrimSpace(query))
	var filtered []Domain

	for _, d := range dl.domains {
		if strings.Contains(strings.ToLower(d.Name), query) {
			filtered = append(filtered, d)
		}
	}

	return filtered
}

// Count returns the number of domains
func (dl *DomainList) Count() int {
	return len(dl.domains)
}

// sort sorts domains alphabetically by name
func (dl *DomainList) sort() {
	sort.Slice(dl.domains, func(i, j int) bool {
		return dl.domains[i].Name < dl.domains[j].Name
	})
}
