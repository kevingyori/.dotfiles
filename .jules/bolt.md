## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2026-04-10 - Prevent O(N) allocations per render tick in hosts-manager
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), deep slice copies (e.g. `Get()`) in frequent loops like `View` or `Update` cause unnecessary O(N) memory allocations per render tick.
**Action:** Prefer returning direct slice references for read-only operations (e.g. `Items()`) to prevent O(N) memory allocations per render tick.
