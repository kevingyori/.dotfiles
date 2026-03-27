## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-27 - UI Slice Allocation Bottleneck
**Learning:** In Go Bubble Tea applications, repeatedly returning deep slice copies (e.g., via `Get()`) during frequent Update or View render loops causes continuous O(N) memory allocations, which degrades UI responsiveness on large lists.
**Action:** Always prefer returning direct slice references (`GetRef()`) for read-only UI rendering operations, but strictly avoid passing these references to asynchronous `tea.Cmd` operations to prevent data races.
