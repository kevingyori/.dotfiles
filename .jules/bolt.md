## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - TUI Render Loop Allocations
**Learning:** In Go Bubble Tea applications, passing deep copies (`Get()`) in frequent UI update/render loops causes excessive O(N) memory allocations per tick.
**Action:** Expose zero-allocation read-only references (e.g., `Items()`) for synchronous UI loops, reserving deep copies for asynchronous tea.Cmd operations to prevent data races.
