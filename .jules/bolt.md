## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-05-10 - Zero-allocation slice references in Go TUIs
**Learning:** In Go Bubble Tea applications, deep slice copies in frequent loops (e.g., View or Update rendering) cause O(N) memory allocations per render tick.
**Action:** Introduce `Items()` for zero-allocation read-only slice references (ideal for UI loops) and keep `Get()` for safe deep copies (ideal for asynchronous `tea.Cmd` operations).
