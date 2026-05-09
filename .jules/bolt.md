## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-05-09 - Bubble Tea Render Loop Memory Allocation
**Learning:** In Go Bubble Tea TUI applications, returning deep slice copies (e.g. `domainList.Get()`) in frequently called UI methods causes O(N) memory allocations per render tick.
**Action:** Use direct slice references (e.g. `domainList.Items()`) for read-only operations in frequent loops (like View or Update rendering) to prevent excessive memory allocations. Reserve deep copies for asynchronous operations (`tea.Cmd`).
