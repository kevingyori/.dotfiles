## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-10-24 - Zero-allocation reads in TUI UI loops
**Learning:** Deep copying slices via Get() in frequently accessed UI read operations triggers unnecessary memory allocations per render tick in Bubble Tea.
**Action:** Use an Items() method to return a zero-allocation reference for read-only UI loops, and reserve deep copies for asynchronous tea.Cmd tasks to avoid data races.
