## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Bubble Tea View Render Optimization
**Learning:** In Go Bubble Tea applications, passing direct slice references to asynchronous commands (`tea.Cmd`) can cause data races if the UI concurrently modifies the slice. Always pass deep copies to asynchronous commands. However, avoid deep slice copies in frequent loops (e.g., View or Update rendering). Prefer returning direct slice references for read-only operations to prevent O(N) memory allocations per render tick.
**Action:** Use direct slice references (e.g. `Items()`) instead of deep copies (e.g. `Get()`) in frequent UI loops, while retaining deep copies for asynchronous commands to prevent data races.
