## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2026-05-07 - Zero-allocation TUI Updates
**Learning:** In Go Bubble Tea applications, the `Update` loop and `View` rendering can fire extremely frequently (e.g., cursor movements, ticks). The hosts-manager project was using `DomainList.Get()` which performs a deep copy of the slice via `make` and `copy`. Calling this during frequent render cycles leads to high memory allocation and GC pressure, causing performance degradation for large datasets.
**Action:** When working with frequently accessed, read-only slices in Go TUI applications, create an `Items()` method that returns a direct slice reference to avoid O(N) memory allocations per render tick. Reserve deep copies (`Get()`) for asynchronous operations (like `tea.Cmd`) to avoid data races.
