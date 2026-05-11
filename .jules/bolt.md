## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI Slice Rendering Allocations
**Learning:** In Bubble Tea TUI applications (like hosts-manager), the `View()` and `Update()` loops run extremely frequently. Returning deep copies of slices (e.g., `DomainList.Get()`) for read-only rendering causes significant memory allocations and GC pressure (O(N) allocations per tick).
**Action:** Expose a zero-allocation reference method (like `Items() []Domain { return dl.domains }`) specifically for synchronous UI loops. Reserve deep copies (`Get()`) only for when passing state to asynchronous `tea.Cmd` operations that might execute concurrently with UI state mutations.
