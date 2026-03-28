## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - TUI Slice Allocation Overhead
**Learning:** In Go Bubble Tea applications, deep-copying slices on every render loop (e.g., using `copy()`) introduces O(N) memory allocations that slow down rapid UI updates.
**Action:** Always return direct slice references (zero-allocation) for read-only View/Update operations in TUI loops, while preserving deep copies (`Get()`) for asynchronous command passing to prevent data races.
