## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-12 - UI Loop Allocations in Bubble Tea
**Learning:** In the `hosts-manager` project, calling `DomainList.Get()` (which performs a deep slice copy) during frequent UI read-only operations (like rendering loops) causes O(N) memory allocations per tick.
**Action:** Use `DomainList.Items()` to return a direct slice reference for read-only UI loops to prevent unnecessary allocations, while reserving `Get()` for asynchronous `tea.Cmd` operations that require safe deep copies.
