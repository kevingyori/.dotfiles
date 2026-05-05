## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-03-12 - TUI Slice Allocations
**Learning:** In Go Bubble Tea applications, deep copying slices (like `m.domainList.Get()`) on every tick or render cycle causes O(N) memory allocations, leading to performance bottlenecks when the slice size grows.
**Action:** Use a direct slice reference (e.g. an `Items()` method returning `[]Domain`) for read-only operations in UI views and frequent loops to prevent memory overhead, while keeping deep copies for async `tea.Cmd` tasks where concurrent modification might be a risk.
