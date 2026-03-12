## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea Render Loop Memory Allocations
**Learning:** In Go Bubble Tea applications, passing deep copies of slices (`m.domainList.Get()`) during frequent render loops causes unnecessary O(N) memory allocations per keystroke/tick.
**Action:** Return direct slice references (`m.domainList.Items()`) for read-only operations in the View/Update loop, but continue using deep copies for asynchronous commands to prevent data races.
