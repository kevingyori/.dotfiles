## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea Memory Allocations
**Learning:** In Go Bubble Tea applications, passing deep copies of slices into frequent UI loops (like View or Update rendering) causes O(N) memory allocations per render tick.
**Action:** Avoid deep slice copies in frequent loops. Prefer returning direct slice references for read-only operations to prevent O(N) memory allocations per render tick.
