## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI State Slicing
**Learning:** In Go Bubble Tea applications, passing deep copies `Get()` during `View` renders causes excessive O(N) memory allocations per tick. However, async commands `tea.Cmd` still require deep copies to avoid data races.
**Action:** Use zero-allocation read-only slice references `Items()` for synchronous UI rendering and filtering, while reserving deep copies `Get()` strictly for asynchronous operations like saves.
