## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-30 - Go Bubble Tea Memory Allocations
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), avoiding deep slice copies in frequent loops (e.g., View or Update rendering) is crucial. Returning direct slice references for read-only operations prevents O(N) memory allocations per render tick.
**Action:** Implement and use methods like `Items()` that provide zero-allocation read-only slice references for UI loops, while reserving `Get()` for safe deep copies (e.g., asynchronous tea.Cmd operations).
