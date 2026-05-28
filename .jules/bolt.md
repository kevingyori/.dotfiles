## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-05-28 - Bubble Tea UI Slice Copy Overhead
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), frequent deep slice copies via methods like `Get()` in UI loops (e.g., View or Update rendering) cause significant memory allocation overhead.
**Action:** Always prefer returning direct slice references for read-only UI rendering loops, while retaining deep copies exclusively for asynchronous `tea.Cmd` operations to prevent data races.
