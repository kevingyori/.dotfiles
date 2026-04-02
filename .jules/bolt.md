## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-02 - Bubble Tea Slice Allocations
**Learning:** In Go Bubble Tea applications, passing deep slice copies (via `Get()`) to frequent loops (like View or Update rendering) causes O(N) memory allocations per tick, leading to memory bloat.
**Action:** Expose a zero-allocation `Items()` method to return a direct slice reference for read-only UI loops, while reserving `Get()` for asynchronous `tea.Cmd` operations to prevent data races.
