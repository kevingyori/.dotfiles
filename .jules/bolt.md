## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Bubble Tea Memory Allocations
**Learning:** In Go Bubble Tea applications, passing deep slice copies (e.g., via `Get()`) to synchronous UI render/filter loops causes O(N) memory allocations per tick.
**Action:** Use zero-allocation direct references (like `Items()`) for frequent UI reads and filtering, reserving deep copies only for asynchronous commands (`tea.Cmd`).
