## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Zero-Allocation Reads in Go TUIs
**Learning:** Returning a deep copy of slices (like `dl.Get()`) in a Bubble Tea application during frequent UI render/update loops causes significant and unnecessary memory allocations per tick, hurting performance.
**Action:** Use direct slice references (like `dl.Items()`) for read-only UI loops and restrict deep copies strictly to asynchronous `tea.Cmd` operations that require safe isolation from concurrent modifications.
