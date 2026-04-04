## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Zero-allocation Read-only Slices in Bubble Tea
**Learning:** In Go Bubble Tea applications, passing direct slice references to UI rendering loops causes data races if the UI concurrently modifies the slice. However, deep copying slices via methods like `Get()` causes excessive O(N) memory allocations per render tick.
**Action:** Provide separate API methods: `Items()` for zero-allocation read-only slice references (ideal for UI rendering loops) and `Get()` for safe deep copies (ideal for asynchronous `tea.Cmd` operations).
