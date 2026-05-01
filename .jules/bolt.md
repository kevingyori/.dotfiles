## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-05-01 - Go TUI View Memory Allocation Bottleneck
**Learning:** In Go Bubble Tea UI loops, performing deep slice copies (e.g., using `Get()` which allocates new memory) on every View/Update tick leads to severe GC pressure and O(N) memory allocations per frame.
**Action:** Introduce an `Items()` method returning a direct zero-allocation slice reference to completely bypass reallocation for read-only UI render logic. Continue using `Get()` exclusively for asynchronous `tea.Cmd` tasks where deep copies are needed to prevent data races.
