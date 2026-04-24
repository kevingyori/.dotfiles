## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Zero-Allocation UI Rendering in Bubble Tea
**Learning:** In Go Bubble Tea applications, passing direct slice references to asynchronous commands (`tea.Cmd`) can cause data races if the UI concurrently modifies the slice. However, deep slice copies in frequent loops (e.g., View or Update rendering) cause O(N) memory allocations per render tick.
**Action:** In the hosts-manager project, use `DomainList.Items()` for zero-allocation read-only slice references (ideal for UI loops) and `DomainList.Get()` for safe deep copies (ideal for asynchronous tea.Cmd operations).
