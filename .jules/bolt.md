## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-12 - Bubble Tea TUI Slice Rendering Allocations
**Learning:** In Go Bubble Tea applications, passing deep slice copies (via `Get()`) during frequent `View` or `Update` loops causes massive zero-value allocations and slows rendering times dramatically.
**Action:** Expose and use `Items()` direct slice references for UI view logic that only requires read-only iteration, reserving `Get()` strictly for async or mutation-safe paths like `tea.Cmd`.
