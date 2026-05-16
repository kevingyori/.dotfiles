## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-12 - Zero-allocation Render Loops in Bubble Tea
**Learning:** In Bubble Tea TUI applications, returning deep copies of slices (like `Get()`) during `View` or `Update` loops causes O(N) memory allocations per render tick. However, passing direct slice references to asynchronous `tea.Cmd` operations can cause data races.
**Action:** Implement dual access methods for collections: `Items()` for zero-allocation read-only access in synchronous UI loops, and `Get()` for safe deep copies when dispatching asynchronous commands.
