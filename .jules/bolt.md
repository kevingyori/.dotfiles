## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI Render Loop Allocations
**Learning:** In Go Bubble Tea TUI applications, returning deep slice copies (`make` + `copy`) from getter methods that are called during frequent loops (like `View` or `Update` rendering) causes significant O(N) memory allocations per render tick, leading to high GC pressure.
**Action:** When a slice is only needed for read-only operations (like iterating for display), implement and use methods that return a direct slice reference instead of a deep copy. Reserve deep copies strictly for operations that might mutate the slice or when passing data to asynchronous `tea.Cmd` operations to prevent data races.
