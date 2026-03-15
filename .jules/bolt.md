## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-05 - TUI Memory Allocations
**Learning:** In Go Bubble Tea applications, passing direct slice references to UI state handlers is preferable when the slice isn't mutated during rendering. Returning deep slice copies via `Get()` in frequent UI loops caused O(N) memory allocation on every key press and render cycle.
**Action:** Use a dedicated `View()` method returning a direct slice reference for read-only UI components, but continue using `Get()` to create deep copies when passing slices to asynchronous `tea.Cmd` handlers to prevent race conditions.
