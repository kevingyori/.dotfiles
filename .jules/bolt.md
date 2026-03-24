## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-24 - Bubble Tea Slice Deep Copies
**Learning:** In Go Bubble Tea TUI applications, passing deep slice copies (e.g., via `Get()`) in frequent loops like `View` or `Update` rendering causes O(N) memory allocations per render tick.
**Action:** Return direct slice references (`Items()`) for read-only operations to prevent unnecessary memory allocations during rendering. Always pass deep copies (`Get()`) to asynchronous commands (`tea.Cmd`) to prevent data races.
