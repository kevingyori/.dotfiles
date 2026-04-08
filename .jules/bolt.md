## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-08 - Go Bubble Tea Memory Allocations
**Learning:** In Bubble Tea apps, returning deep copies of slices (e.g., via `Get()`) in frequent read-only operations like UI renders or search filtering causes constant O(N) memory allocations per frame/update tick.
**Action:** Always provide zero-allocation slice references (e.g., `Items()`) for read-only UI loops, and reserve deep copies exclusively for asynchronous `tea.Cmd` operations to prevent data races.
