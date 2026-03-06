## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2026-04-18 - TUI View Loop Memory Allocations
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), avoiding deep slice copies in frequent loops (e.g., View or Update rendering) is critical. Returning copies of slices in functions called on every render tick leads to O(N) memory allocations, quickly degrading performance as lists grow.
**Action:** Prefer returning direct slice references for read-only operations in TUI view/update loops to prevent O(N) memory allocations per render tick.
