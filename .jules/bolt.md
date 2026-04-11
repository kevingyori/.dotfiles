## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI Slice Allocations
**Learning:** In Bubble Tea TUI applications like `hosts-manager`, using deep slice copies (like `Get()`) in frequent UI loops (like `View` or `Update`) causes massive O(N) memory allocations per render tick.
**Action:** Always provide and use a direct read-only reference (like `Items()`) for frequent UI access. Only use deep copies (like `Get()`) when passing slices to asynchronous operations (like `tea.Cmd`) to avoid data races.
