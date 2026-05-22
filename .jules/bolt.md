## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Bubble Tea Memory Allocations
**Learning:** In Go Bubble Tea applications, deep-copying slices on every `View()` or `Update()` call (like `m.domainList.Get()`) causes unnecessary O(N) memory allocations per render tick.
**Action:** Return direct slice references (e.g., `Items()`) for read-only view operations instead of full copies, while retaining deep copies only when passing slices to asynchronous `tea.Cmd`.
