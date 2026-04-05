## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-05 - Bubble Tea Zero-Allocation Reads
**Learning:** In Go Bubble Tea applications, passing deep copies of slices (via `Get()`) during frequent UI loop events (like View or Update) causes significant O(N) memory allocation overhead on every render tick. However, direct slice references are unsafe for asynchronous operations.
**Action:** Expose an `Items()` method for zero-allocation, read-only slice references to be used strictly within synchronous UI rendering and filtering loops, while reserving the `Get()` method for creating safe deep copies when passing data to asynchronous `tea.Cmd` operations.
