package main

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"
	"time"

	"github.com/charmbracelet/bubbles/textinput"
	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

// Styles
var (
	titleStyle    = lipgloss.NewStyle().Foreground(lipgloss.Color("212")).Bold(true)
	cursorStyle   = lipgloss.NewStyle().Foreground(lipgloss.Color("212"))
	selectedStyle = lipgloss.NewStyle().Foreground(lipgloss.Color("33"))
	helpStyle     = lipgloss.NewStyle().Foreground(lipgloss.Color("240"))
	errorStyle    = lipgloss.NewStyle().Foreground(lipgloss.Color("196"))
	statusStyle   = lipgloss.NewStyle().Foreground(lipgloss.Color("82"))
	dirtyStyle    = lipgloss.NewStyle().Foreground(lipgloss.Color("208")).Bold(true)
	quitStyle     = lipgloss.NewStyle().Foreground(lipgloss.Color("82")).Bold(true)
	dialogBox     = lipgloss.NewStyle().Border(lipgloss.RoundedBorder()).
			BorderForeground(lipgloss.Color("212")).Padding(1, 1)
)

// Messages for async operations
type DomainsLoadedMsg []Domain
type DomainsSavedMsg struct{ err error }

// Model wraps UIModel for Bubble Tea
type Model struct {
	ui *UIModel
}

func initialModel() Model {
	hostsManager := NewHostsManager("")
	// Set initial sudo refresh time to now since we just validated credentials
	hostsManager.SetInitialSudoRefresh(time.Now())
	return Model{
		ui: NewUIModel(hostsManager),
	}
}

func (m Model) Init() tea.Cmd {
	return loadDomainsCmd(m.ui.hostsManager)
}

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd

	switch msg := msg.(type) {
	case tea.KeyMsg:
		return m.handleKeyMsg(msg)
	case DomainsLoadedMsg:
		m.ui.SetDomains([]Domain(msg))
		return m, nil
	case DomainsSavedMsg:
		if msg.err != nil {
			m.ui.SetError(msg.err)
		} else {
			m.ui.SetClean()
			m.ui.SetStatus("Changes saved and DNS flushed!")
		}
		return m, nil
	case error:
		m.ui.SetError(msg)
		return m, nil
	}

	// Update paginator and clamp cursor
	m.ui.paginator, cmd = m.ui.paginator.Update(msg)
	m.ui.ClampCursor()

	return m, cmd
}

func (m Model) handleKeyMsg(msg tea.KeyMsg) (tea.Model, tea.Cmd) {
	switch m.ui.state {
	case StateAdding:
		return m.handleAddingState(msg)
	case StateSearching:
		return m.handleSearchingState(msg)
	case StateDeleting:
		return m.handleDeletingState(msg)
	default:
		return m.handleMainState(msg)
	}
}

func (m Model) handleAddingState(msg tea.KeyMsg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd

	switch msg.String() {
	case "ctrl+c", "esc":
		m.ui.state = StateMain
		m.ui.textInput.Reset()
		return m, nil
	case "enter":
		newDomainName := strings.TrimSpace(m.ui.textInput.Value())
		if newDomainName != "" {
			m.ui.AddDomain(newDomainName)
			m.ui.state = StateMain
			m.ui.textInput.Reset()
		}
		return m, nil
	}

	m.ui.textInput, cmd = m.ui.textInput.Update(msg)
	return m, cmd
}

func (m Model) handleSearchingState(msg tea.KeyMsg) (tea.Model, tea.Cmd) {
	var cmd tea.Cmd

	switch msg.String() {
	case "esc":
		m.ui.state = StateMain
		m.ui.ClearSearch()
		return m, nil
	case "enter":
		m.ui.state = StateMain
		m.ui.searchInput.Blur()
		return m, nil
	}

	m.ui.searchInput, cmd = m.ui.searchInput.Update(msg)
	m.ui.FilterDomains()
	return m, cmd
}

func (m Model) handleDeletingState(msg tea.KeyMsg) (tea.Model, tea.Cmd) {
	switch msg.String() {
	case "y", "Y":
		if m.ui.DeleteSelectedDomain() {
			m.ui.state = StateMain
			return m, saveDomainsCmd(m.ui.hostsManager, m.ui.domainList.Get())
		}
		m.ui.state = StateMain
		return m, nil
	case "n", "N", "esc":
		m.ui.state = StateMain
		return m, nil
	}
	return m, nil
}

func (m Model) handleMainState(msg tea.KeyMsg) (tea.Model, tea.Cmd) {
	switch msg.String() {
	case "ctrl+c", "q":
		m.ui.quitMsg = "Hosts file tamed. Happy browsing!"
		return m, tea.Quit
	case "/":
		m.ui.state = StateSearching
		m.ui.searchInput.Focus()
		return m, textinput.Blink
	case "up", "k":
		if m.ui.cursor > 0 {
			m.ui.cursor--
		}
	case "down", "j":
		currentDomains := m.ui.GetCurrentDomains()
		start, end := m.ui.paginator.GetSliceBounds(len(currentDomains))
		if m.ui.cursor < len(currentDomains[start:end])-1 {
			m.ui.cursor++
		}
	case "left", "h":
		m.ui.paginator.PrevPage()
	case "right", "l":
		m.ui.paginator.NextPage()
	case "a":
		m.ui.state = StateAdding
		return m, textinput.Blink
	case "d":
		currentDomains := m.ui.GetCurrentDomains()
		start, end := m.ui.paginator.GetSliceBounds(len(currentDomains))
		if len(currentDomains[start:end]) > 0 {
			m.ui.state = StateDeleting
		}
	case " ":
		if m.ui.ToggleSelectedDomain() {
			// Domain was toggled successfully
		}
	case "s":
		m.ui.SetStatus("Saving changes...")
		return m, saveDomainsCmd(m.ui.hostsManager, m.ui.domainList.Get())
	}

	return m, nil
}

func (m Model) View() string {
	return m.renderMainView()
}

func (m Model) renderMainView() string {
	var b strings.Builder
	title := titleStyle.Render("Hosts File Manager")
	if m.ui.IsDirty() {
		title += dirtyStyle.Render(" [Unsaved]")
	}
	b.WriteString(title + "\n\n")

	currentDomains := m.ui.GetCurrentDomains()
	start, end := m.ui.paginator.GetSliceBounds(len(currentDomains))
	paginatedDomains := currentDomains[start:end]

	numRendered := len(paginatedDomains)
	if numRendered == 0 {
		if m.ui.searchInput.Value() != "" {
			b.WriteString(helpStyle.Render("No domains match your search.") + "\n")
		} else {
			b.WriteString(helpStyle.Render("No domains managed yet. Press 'a' to add one.") + "\n")
		}
		numRendered = 1 // Account for the empty state message line
	} else {
		for i, d := range paginatedDomains {
			cursor := " "
			if m.ui.cursor == i {
				cursor = ">"
			}
			checkbox := "[ ]"
			if d.Blocked {
				checkbox = selectedStyle.Render("[✔]")
			}
			row := fmt.Sprintf("%s %s %s", cursor, checkbox, d.Name)
			if m.ui.cursor == i {
				b.WriteString(cursorStyle.Render(row) + "\n")
			} else {
				b.WriteString(row + "\n")
			}
		}
	}

	// Fill remaining space
	for i := numRendered; i < m.ui.paginator.PerPage; i++ {
		b.WriteString("\n")
	}

	b.WriteString("\n" + m.ui.paginator.View() + "\n")

	// Show mode-specific UI or general help
	switch m.ui.state {
	case StateAdding:
		b.WriteString(statusStyle.Render("Enter new domain name:") + "\n")
		b.WriteString(m.ui.textInput.View() + "\n")
		b.WriteString(helpStyle.Render("enter: confirm, esc: cancel") + "\n")
	case StateDeleting:
		domain, ok := m.ui.GetSelectedDomain()
		if ok {
			question := fmt.Sprintf("Are you sure you want to delete '%s'? (y/n)", domain.Name)
			b.WriteString(errorStyle.Render(question) + "\n")
		}
	case StateSearching:
		b.WriteString(helpStyle.Render("j/k/↑/↓: navigate  h/l/←/→: pages") + "\n")
		b.WriteString(helpStyle.Render("space: toggle  a: add  d: delete  s: save  /: search  q: quit") + "\n")
		b.WriteString("\n" + "Search: " + m.ui.searchInput.View() + "\n")
		b.WriteString(helpStyle.Render("enter: keep filter, esc: clear filter"))
	default: // StateMain
		b.WriteString(helpStyle.Render("j/k/↑/↓: navigate  h/l/←/→: pages") + "\n")
		b.WriteString(helpStyle.Render("space: toggle  a: add  d: delete  s: save  /: search  q: quit") + "\n")
	}

	if m.ui.statusMsg != "" {
		b.WriteString("\n" + statusStyle.Render(m.ui.statusMsg))
	}
	if m.ui.errorMsg != "" {
		b.WriteString("\n" + errorStyle.Render(m.ui.errorMsg))
	}

	return b.String()
}

// Commands for async operations
func loadDomainsCmd(hm *HostsManager) tea.Cmd {
	return func() tea.Msg {
		domains, err := hm.LoadDomains()
		if err != nil {
			return err
		}
		return DomainsLoadedMsg(domains)
	}
}

func saveDomainsCmd(hm *HostsManager, domains []Domain) tea.Cmd {
	return func() tea.Msg {
		err := hm.SaveDomains(domains)
		return DomainsSavedMsg{err: err}
	}
}

func main() {
	fmt.Println("Requesting sudo access to manage /etc/hosts...")
	cmd := exec.Command("sudo", "-v")
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	if err := cmd.Run(); err != nil {
		log.Fatalf("Failed to get sudo access. Please try again. Error: %v", err)
	}

	clearCmd := exec.Command("clear")
	clearCmd.Stdout = os.Stdout
	clearCmd.Run()

	p := tea.NewProgram(initialModel(), tea.WithAltScreen())
	m, err := p.Run()
	if err != nil {
		log.Fatalf("Alas, there's been an error: %v", err)
	}

	if finalModel, ok := m.(Model); ok && finalModel.ui.quitMsg != "" {
		fmt.Println(quitStyle.Render(finalModel.ui.quitMsg))
	}
}
