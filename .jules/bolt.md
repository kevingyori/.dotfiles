## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2024-05-31 - Zero-allocation slice references in TUI render loops
**Learning:** In TUI applications (like Bubble Tea), continuously calling methods that perform deep copies (like `Get()` making a full copy of an array) during the render loop or standard UI interaction loops causes significant unnecessary garbage collection overhead and memory allocations.
**Action:** Implement `Items()` or similar accessors that return direct, zero-allocation slice references for read-only UI loops, while reserving deep-copy `Get()` methods strictly for concurrent or asynchronous updates where data races are a risk.
