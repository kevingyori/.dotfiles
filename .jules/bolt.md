## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-12 - Zero-Allocation Reads in Bubble Tea
**Learning:** In Bubble Tea TUI apps, `View()` and `Update()` loops run frequently. Calling methods that deep copy slices (like `Get()`) inside these loops causes O(N) memory allocations per render tick, leading to unnecessary GC pressure and slowdowns.
**Action:** Expose a read-only slice reference method (e.g., `Items()`) alongside safe deep-copy methods (e.g., `Get()`). Use `Items()` strictly for synchronous UI rendering and `Get()` for asynchronous operations (like `tea.Cmd`) to prevent data races.
