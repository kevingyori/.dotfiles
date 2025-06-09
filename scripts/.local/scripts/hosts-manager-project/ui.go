package main

import (
	"fmt"
	"strings"

	"github.com/charmbracelet/bubbles/paginator"
	"github.com/charmbracelet/bubbles/textinput"
)

// UI State constants
type UIState int

const (
	StateMain UIState = iota
	StateAdding
	StateDeleting
	StateSearching
)

// Styles are defined in main.go

// UIModel represents the UI state
type UIModel struct {
	domainList      *DomainList
	hostsManager    *HostsManager
	filteredDomains []Domain
	paginator       paginator.Model
	cursor          int
	textInput       textinput.Model
	searchInput     textinput.Model
	state           UIState
	statusMsg       string
	errorMsg        string
	quitMsg         string
}

// NewUIModel creates a new UI model
func NewUIModel(hostsManager *HostsManager) *UIModel {
	// Setup text input for adding domains
	ti := textinput.New()
	ti.Placeholder = "e.g., distracting.com"
	ti.Focus()
	ti.CharLimit = 156
	ti.Width = 30

	// Setup search input
	si := textinput.New()
	si.Placeholder = "Search domains..."
	si.CharLimit = 100
	si.Width = 30

	// Setup paginator
	p := paginator.New()
	p.Type = paginator.Dots
	p.PerPage = 10

	return &UIModel{
		domainList:      NewDomainList(),
		hostsManager:    hostsManager,
		filteredDomains: []Domain{},
		paginator:       p,
		textInput:       ti,
		searchInput:     si,
		state:           StateMain,
	}
}

// GetCurrentDomains returns the currently displayed domains (filtered or all)
func (m *UIModel) GetCurrentDomains() []Domain {
	if m.searchInput.Value() != "" {
		return m.filteredDomains
	}
	return m.domainList.Get()
}

// FilterDomains updates the filtered domains based on search input
func (m *UIModel) FilterDomains() {
	searchQuery := strings.ToLower(strings.TrimSpace(m.searchInput.Value()))
	wasFiltered := len(m.filteredDomains) != m.domainList.Count() && len(m.filteredDomains) > 0

	if searchQuery == "" {
		m.filteredDomains = m.domainList.Get()
		if wasFiltered {
			m.cursor = 0
		}
	} else {
		oldFilteredCount := len(m.filteredDomains)
		m.filteredDomains = m.domainList.Filter(searchQuery)
		if !wasFiltered || oldFilteredCount != len(m.filteredDomains) {
			m.cursor = 0
		}
	}
	m.paginator.SetTotalPages(len(m.filteredDomains))
}

// ClampCursor ensures cursor is within valid bounds
func (m *UIModel) ClampCursor() {
	currentDomains := m.GetCurrentDomains()
	start, end := m.paginator.GetSliceBounds(len(currentDomains))

	if end > start {
		if m.cursor >= end-start {
			m.cursor = end - start - 1
		}
		if m.cursor < 0 {
			m.cursor = 0
		}
	} else {
		m.cursor = 0
	}
}

// GetSelectedDomain returns the currently selected domain
func (m *UIModel) GetSelectedDomain() (Domain, bool) {
	currentDomains := m.GetCurrentDomains()
	start, end := m.paginator.GetSliceBounds(len(currentDomains))
	paginatedDomains := currentDomains[start:end]

	if len(paginatedDomains) == 0 || m.cursor >= len(paginatedDomains) {
		return Domain{}, false
	}

	return paginatedDomains[m.cursor], true
}

// AddDomain adds a new domain
func (m *UIModel) AddDomain(name string) {
	m.domainList.Add(name)
	m.FilterDomains()
	m.statusMsg = fmt.Sprintf("Added '%s'. Press 's' to save.", name)
}

// DeleteSelectedDomain deletes the currently selected domain
func (m *UIModel) DeleteSelectedDomain() bool {
	domain, ok := m.GetSelectedDomain()
	if !ok {
		return false
	}

	if m.domainList.Remove(domain.Name) {
		m.FilterDomains()
		m.statusMsg = fmt.Sprintf("Deleting '%s'...", domain.Name)
		return true
	}
	return false
}

// ToggleSelectedDomain toggles the blocking status of the selected domain
func (m *UIModel) ToggleSelectedDomain() bool {
	domain, ok := m.GetSelectedDomain()
	if !ok {
		return false
	}

	if m.domainList.Toggle(domain.Name) {
		// Store current position
		currentPage := m.paginator.Page
		cursorPos := m.cursor

		m.FilterDomains()

		// Restore position
		m.paginator.Page = currentPage
		m.cursor = cursorPos
		m.ClampCursor()

		m.statusMsg = fmt.Sprintf("Toggled '%s'. Press 's' to save.", domain.Name)
		return true
	}
	return false
}

// SetDomains sets the domain list
func (m *UIModel) SetDomains(domains []Domain) {
	m.domainList.Set(domains)
	m.filteredDomains = m.domainList.Get()
	m.paginator.SetTotalPages(len(m.filteredDomains))
	m.statusMsg = "Hosts file loaded."
}

// ClearSearch clears the search filter
func (m *UIModel) ClearSearch() {
	hadSearchValue := m.searchInput.Value() != ""
	m.searchInput.Reset()
	m.searchInput.Blur()
	m.filteredDomains = m.domainList.Get()
	m.paginator.SetTotalPages(m.domainList.Count())
	if hadSearchValue {
		m.cursor = 0
	}
}

// SetError sets an error message
func (m *UIModel) SetError(err error) {
	m.errorMsg = fmt.Sprintf("Error: %v", err)
}

// SetStatus sets a status message
func (m *UIModel) SetStatus(msg string) {
	m.statusMsg = msg
}

// ClearMessages clears status and error messages
func (m *UIModel) ClearMessages() {
	m.statusMsg = ""
	m.errorMsg = ""
}
