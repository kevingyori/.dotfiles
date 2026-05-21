## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-05-21 - Bubble Tea Slice Allocation Anti-Pattern
**Learning:** In the `hosts-manager` application, deep-copying the domains slice on every render tick via `Get()` causes excessive `O(N)` memory allocations. However, passing direct references to asynchronous `tea.Cmd` tasks can cause data races.
**Action:** Use a zero-allocation `Items()` method returning a slice reference for read-only UI loops, and reserve `Get()` (deep copies) strictly for asynchronous `tea.Cmd` operations.
