## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea Memory Allocations
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), avoiding deep slice copies in frequent loops (e.g., View or Update rendering) is critical. Deep copies cause O(N) memory allocations per render tick.
**Action:** Prefer returning direct slice references for read-only operations to prevent unnecessary memory allocations, while reserving deep copies for asynchronous tea.Cmd operations.
