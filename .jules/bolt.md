## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Go Bubble Tea Memory Allocations
**Learning:** Deep copying slices in TUI application methods that are called frequently (like during `Update` or `View` ticks in Bubble Tea) causes severe O(N) memory allocations per tick.
**Action:** Avoid deep copies in these hot paths. Instead, return references to slices directly if they are meant to be read-only for rendering.