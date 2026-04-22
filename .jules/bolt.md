## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-22 - TUI Render Loop Allocations
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), passing deep slice copies via `Get()` in frequent UI loops (like `View` or `Update`) causes unnecessary O(N) memory allocations per render tick.
**Action:** Use a direct slice reference like `Items()` for read-only UI loops to prevent memory allocations, and reserve `Get()` for safe deep copies (e.g., passing to asynchronous `tea.Cmd` operations).
