## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2024-05-06 - Bubble Tea Slice References
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), avoid deep slice copies in frequent loops (e.g., View or Update rendering).
**Action:** Prefer returning direct slice references for read-only operations to prevent O(N) memory allocations per render tick.
