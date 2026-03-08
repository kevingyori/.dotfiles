## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2024-03-08 - TUI Render Loop Allocations
**Learning:** Deep copying slices on every render tick in Go Bubble Tea applications causes O(N) memory allocations, degrading performance. Passing direct slice references to asynchronous commands (tea.Cmd) causes data races.
**Action:** Return direct slice references for read-only View/Update operations and create explicit deep copies (`Clone()`) when passing data to asynchronous commands.
