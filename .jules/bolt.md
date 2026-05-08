## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Zero-Allocation Reads in Go TUIs
**Learning:** In Go Bubble Tea TUI applications, returning deep slice copies (like `Get()`) in frequent read-only operations (like `View` or `Update` rendering loops) causes unnecessary O(N) memory allocations per render tick.
**Action:** Provide an `Items()` method that returns a direct, zero-allocation slice reference for read-only UI loops, reserving deep copies (`Get()`) for asynchronous `tea.Cmd` operations where data races might occur.
