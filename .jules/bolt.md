## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## $(date +%Y-%m-%d) - Bubble Tea Slice Reference Optimization
**Learning:** In Go Bubble Tea applications, passing deep slice copies in frequent loops (e.g., View or Update rendering) causes unnecessary O(N) memory allocations per render tick.
**Action:** Prefer returning direct slice references for read-only operations to prevent memory allocation overhead, while continuing to pass deep copies to asynchronous commands (`tea.Cmd`) to prevent data races.
