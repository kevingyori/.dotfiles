## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Go Bubble Tea Rendering Loops
**Learning:** Deep slice copies in Bubble Tea render loops cause O(N) memory allocations per render tick, hurting UI performance.
**Action:** In frequent loops (e.g. View/Update), return direct slice references for read-only operations.
