## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Avoid O(N) slice copies in Go TUI renders
**Learning:** Deep copying slices via `copy()` inside frequent TUI operations (like `Update` or `View` in Bubble Tea) causes an O(N) memory allocation per render tick, leading to high garbage collection pressure.
**Action:** Return direct slice references for read-only UI loops, reserving deep copies specifically for asynchronous commands (`tea.Cmd`) to prevent data races.
