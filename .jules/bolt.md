## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Zero-Allocation Slice References in Bubble Tea
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), passing deep slice copies in frequent loops (e.g., View or Update rendering) causes O(N) memory allocations per render tick.
**Action:** Avoid deep slice copies. Prefer returning direct slice references for read-only operations to prevent memory allocations. Use deep copies (e.g., Get()) only for asynchronous operations like tea.Cmd where concurrent modifications could cause data races.
