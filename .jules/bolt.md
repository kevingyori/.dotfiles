## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-25 - Bubble Tea TUI Render Loop Allocations
**Learning:** Returning deep slice copies using `make()` and `copy()` in frequent loops (like Bubble Tea's `Update` or `View` ticks) causes O(N) memory allocations per render cycle. This creates significant garbage collection overhead in TUI apps rendering large lists.
**Action:** Expose a method like `GetAll()` that returns a direct slice reference for read-only operations to prevent allocation overhead, while keeping deep copies strictly for state mutation or asynchronous commands (`tea.Cmd`) to avoid data races.
