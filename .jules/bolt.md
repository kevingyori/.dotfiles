## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-11 - Bubble Tea UI Allocations
**Learning:** In Go Bubble Tea TUI applications, returning deep copies of slices (e.g., `DomainList.Get()`) inside frequent loops like View or Update rendering causes unnecessary O(N) memory allocations per render tick.
**Action:** Use direct slice references (e.g., `DomainList.Items()`) for zero-allocation read-only access in UI render loops, reserving deep copies solely for safe asynchronous operations like `tea.Cmd`.
