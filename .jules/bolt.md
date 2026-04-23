## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2026-04-23 - TUI Render Loop Allocations
**Learning:** Calling `m.domainList.Get()` in frequent UI render loops (like `View` or `Update`) creates an O(N) deep copy per tick, killing performance. For Bubble Tea applications, passing deep copies is necessary for async commands (`tea.Cmd`) to avoid races, but direct slice references are better for synchronous read-only UI loops.
**Action:** Implement and use a zero-allocation `Items()` method to return a direct slice reference for read-only UI operations, while preserving `Get()` for deep copies needed by async updates.
