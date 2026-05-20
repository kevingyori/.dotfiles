## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Zero-Allocation Read-Only Slice References in Go TUI Applications
**Learning:** In Go Bubble Tea TUI applications, passing direct slice references to UI loops instead of deep copies via `Get()` avoids O(N) memory allocations per render tick, improving efficiency.
**Action:** Add an `Items()` method to return zero-allocation read-only slice references for UI loops, while preserving `Get()` for safe deep copies.
