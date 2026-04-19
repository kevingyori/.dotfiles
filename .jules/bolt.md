## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## $(date +%Y-%m-%d) - Zero-Allocation UI Rendering in Bubble Tea
**Learning:** In Go UI frameworks like Bubble Tea, returning deep copies of slices (e.g., `Get()`) for frequent read operations like filtering or rendering causes massive O(N) memory allocations per render tick, putting heavy pressure on the garbage collector.
**Action:** For read-only UI loops, provide an `Items()` method that returns a direct slice reference to prevent allocations. Reserve deep copies (`Get()`) strictly for asynchronous operations (`tea.Cmd`) to avoid data races.
