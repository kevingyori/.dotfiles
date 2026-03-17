## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - TUI Deep Slice Copying
**Learning:** In Go Bubble Tea applications, deep-copying slices (`dl.Get()`) on every view render tick or keystroke causes severe O(N) memory allocations, leading to high garbage collection pressure.
**Action:** Always return direct slice references (`dl.Items()`) for read-only View/Update rendering paths to prevent allocation overhead. Only deep copy data when passing it to asynchronous `tea.Cmd`.
