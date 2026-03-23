## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI Slice Allocation Anti-Pattern
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), passing deep slice copies (`Get()`) in frequent loops (e.g., View or Update rendering) causes O(N) memory allocations per render tick, slowing down UI interactions and increasing garbage collection overhead.
**Action:** Avoid deep slice copies in frequent loops. Prefer returning direct slice references (`Items()`) for read-only operations to prevent unnecessary memory allocations, while still passing deep copies to asynchronous commands (`tea.Cmd`) to prevent data races.
