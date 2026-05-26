## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-05-26 - Bubble Tea Loop Deep Copies
**Learning:** Deep copying slices via `Get()` inside Bubble Tea `View` or `Update` loops causes O(N) memory allocations per tick, significantly degrading UI performance.
**Action:** Always prefer zero-allocation read-only slice references (like `Items()`) for frequent UI rendering loops, and reserve deep copies exclusively for asynchronous `tea.Cmd` operations to prevent data races.
