## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2024-03-10 - Bubble Tea Render Loop Allocations
**Learning:** In Go Bubble Tea applications, passing deep slice copies (like `Get()`) to frequent loops like `View` or `Update` causes O(N) memory allocations per render tick.
**Action:** Use direct slice references (e.g., `Items()`) for read-only operations in UI loops to prevent excessive memory allocations.
