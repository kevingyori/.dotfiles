## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-31 - Zero-Allocation Read-Only Slice References in TUI Render Loops
**Learning:** In Go Bubble Tea applications, passing deep slice copies (`Get()`) in frequent loops like `View` or `Update` causes O(N) memory allocations per render tick.
**Action:** Use zero-allocation read-only slice references (`Items()`) for UI rendering loops, but keep using deep copies (`Get()`) for asynchronous `tea.Cmd` operations to prevent data races.
