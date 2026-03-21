## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## $(date +%Y-%m-%d) - Bubbletea Slice References vs Copies
**Learning:** In Go Bubble Tea applications, repeatedly making deep slice copies (e.g., allocating a new slice on every View or Update render tick) incurs significant performance overhead. However, returning direct slice references to asynchronous `tea.Cmd`s causes data races if the main UI thread continues modifying the original slice.
**Action:** Prefer returning direct slice references for synchronous, read-only UI loops to avoid O(N) memory allocations per tick. Only create and pass deep copies when handing data off to asynchronous operations (like saving to disk).
