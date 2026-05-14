## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-05-14 - DomainList deep copies vs references
**Learning:** In the `hosts-manager` project, `DomainList.Get()` creates a deep copy of the domains slice. Using this in UI rendering loops causes O(N) memory allocations per tick. `Items()` should be used for zero-allocation read-only references, while `Get()` should be reserved for passing data to asynchronous operations (like `tea.Cmd`) to avoid data races.
**Action:** When working with slices in Bubble Tea update/view loops, provide a zero-allocation method to return the slice directly for read-only access. Only use deep copies when passing slices into asynchronous commands to prevent race conditions.
