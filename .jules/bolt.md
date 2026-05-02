## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-05-02 - Bubble Tea Slice Allocation Bottlenecks
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), avoid deep slice copies in frequent loops (e.g., View or Update rendering). Passing direct slice references to asynchronous commands (`tea.Cmd`) can cause data races if the UI concurrently modifies the slice, but for read-only operations (like UI loops), returning a deep copy (like `Get()`) causes O(N) memory allocations per render tick.
**Action:** Use a dual-API pattern: `Items()` for zero-allocation read-only slice references (ideal for UI loops) and `Get()` for safe deep copies (ideal for asynchronous tea.Cmd operations).
