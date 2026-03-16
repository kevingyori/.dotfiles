## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Avoid Deep Slices Copy in Frequent Bubble Tea Loops
**Learning:** In Go Bubble Tea applications (like hosts-manager), passing deep slice copies via methods like `Get()` in frequent loops (e.g., View or Update rendering) causes O(N) memory allocations per render tick, leading to unnecessary garbage collection overhead and potential performance stutters.
**Action:** Prefer returning direct slice references (e.g., via `Items()`) for read-only operations to prevent memory allocations. Only use deep slice copies when passing data to asynchronous commands (like `tea.Cmd`) to avoid data races.
