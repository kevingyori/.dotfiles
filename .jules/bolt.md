## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea Render Loop Slice Allocations
**Learning:** Deep copying slices via `Get()` in read-only UI loops (like Bubble Tea's `Update` and `View`) causes O(N) memory allocations per render tick, degrading performance. However, direct slice references passed to asynchronous `tea.Cmd` operations can cause data races.
**Action:** Provide both `Items()` (zero-allocation reference for UI loops) and `Get()` (deep copy for async commands) in data APIs to balance performance and safety.
