## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-28 - Zero-allocation reads in Bubble Tea TUI
**Learning:** In Go Bubble Tea applications, deep slice copies in frequent loops (e.g., View or Update rendering) cause O(N) memory allocations per render tick.
**Action:** Use direct slice references for read-only operations to prevent unnecessary allocations, while still retaining deep copies for asynchronous tea.Cmd operations.
