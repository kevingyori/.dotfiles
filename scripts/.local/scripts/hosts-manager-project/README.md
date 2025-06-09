# Hosts File Manager

A clean, modular TUI application for managing domain blocking via the `/etc/hosts` file.

## Features

- **Domain Management**: Add, remove, and toggle blocking status of domains
- **Search & Filter**: Real-time search through your domain list
- **Pagination**: Navigate through large lists of domains efficiently
- **Safe Operations**: Manages a dedicated block in `/etc/hosts` without affecting other entries
- **DNS Cache Flushing**: Automatically flushes DNS cache after changes (macOS)

## Architecture

The application has been refactored into clean, modular components:

### Core Components

- **`domain.go`**: Domain data structures and business logic
  - `Domain`: Represents a domain with name and blocking status
  - `DomainList`: Manages collections of domains with operations like add, remove, toggle, filter

- **`hosts.go`**: Hosts file operations
  - `HostsManager`: Handles reading from and writing to the hosts file
  - Manages the dedicated block markers in `/etc/hosts`
  - Handles DNS cache flushing

- **`ui.go`**: UI state management
  - `UIModel`: Manages UI state, pagination, search, and user interactions
  - Separates UI logic from business logic

- **`main.go`**: Application entry point and Bubble Tea integration
  - `Model`: Bubble Tea model that wraps UIModel
  - Event handling and view rendering
  - Async command handling

### Key Improvements

1. **Separation of Concerns**: Business logic, UI state, and file operations are cleanly separated
2. **Testability**: Each component can be tested independently
3. **Maintainability**: Clear interfaces and single responsibilities
4. **Error Handling**: Proper error propagation and user feedback
5. **Type Safety**: Strong typing throughout the application

## Usage

```bash
# Build the application
go build -o hosts-manager

# Run the application (requires sudo for hosts file access)
./hosts-manager
```

### Keyboard Controls

- `j/k` or `↑/↓`: Navigate through domains
- `h/l` or `←/→`: Navigate between pages
- `Space`: Toggle domain blocking status
- `a`: Add new domain
- `d`: Delete selected domain
- `/`: Search/filter domains
- `s`: Save changes to hosts file
- `q` or `Ctrl+C`: Quit

### Search Mode

- Type to filter domains in real-time
- `Enter`: Keep current filter
- `Esc`: Clear filter and return to full list

## Testing

The application includes comprehensive tests for all core functionality:

```bash
# Run all tests
go test -v

# Run specific test files
go test -v domain_test.go domain.go
go test -v hosts_test.go hosts.go
```

### Test Coverage

- **Domain Operations**: Add, remove, toggle, filter, sorting
- **Hosts File Parsing**: Reading managed blocks, handling comments
- **Block Generation**: Creating properly formatted hosts entries
- **Edge Cases**: Empty files, missing blocks, duplicate domains

## File Structure

```
hosts-manager-project/
├── main.go           # Application entry point and Bubble Tea integration
├── domain.go         # Domain data structures and business logic
├── hosts.go          # Hosts file operations
├── ui.go             # UI state management
├── domain_test.go    # Tests for domain functionality
├── hosts_test.go     # Tests for hosts file operations
├── go.mod            # Go module definition
├── go.sum            # Go module checksums
└── README.md         # This file
```

## How It Works

1. **Initialization**: Creates a `HostsManager` and `UIModel`
2. **Loading**: Reads existing domains from the managed block in `/etc/hosts`
3. **User Interaction**: Handles keyboard input through Bubble Tea
4. **Domain Operations**: Modifies the in-memory domain list
5. **Saving**: Writes changes back to `/etc/hosts` and flushes DNS cache

### Hosts File Management

The application manages a dedicated block in `/etc/hosts`:

```
# --- HOSTS_MANAGER_BLOCK_START ---
127.0.0.1 example.com
127.0.0.1 www.example.com
# 127.0.0.1 test.com
# 127.0.0.1 www.test.com
# --- HOSTS_MANAGER_BLOCK_END ---
```

- Active blocks redirect domains to `127.0.0.1` (localhost)
- Commented lines represent unblocked domains
- Both `domain.com` and `www.domain.com` are managed
- Content outside the managed block is preserved

## Requirements

- Go 1.19+
- macOS (for DNS cache flushing commands)
- sudo access (for modifying `/etc/hosts`)

## Dependencies

- [Bubble Tea](https://github.com/charmbracelet/bubbletea): TUI framework
- [Bubbles](https://github.com/charmbracelet/bubbles): TUI components
- [Lipgloss](https://github.com/charmbracelet/lipgloss): Styling 