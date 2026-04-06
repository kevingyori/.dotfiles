## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-06 - Bubble Tea Slice Allocations
**Learning:** Deep copies of slices (e.g. `make` + `copy`) in Bubble Tea view/update UI loops cause excessive memory allocations every render tick.
**Action:** Avoid deep slice copies for read-only view states by returning direct references. Continue using deep copies only when passing slices to asynchronous `tea.Cmd` commands to prevent data races.
