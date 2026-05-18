## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - TUI Slice Allocation Optimization
**Learning:** In Go Bubble Tea TUI applications, frequent render ticks often fetch list state. Returning deep slice copies via `Get()` creates significant O(N) memory allocations per render cycle, which causes garbage collection pressure.
**Action:** Expose a zero-allocation `Items()` method that returns a direct slice reference for use in read-only UI render loops, while reserving `Get()` for asynchronous updates or mutable operations.
