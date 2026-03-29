## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea View Loop Allocation
**Learning:** Deep slice copies (O(N) allocations) inside frequent UI view or update loops cause unnecessary memory pressure and lag. For read-only operations, returning direct slice references is much more performant.
**Action:** Avoid deep slice copies for read-only state access in TUI applications. Return direct slice references from models when safe to do so.
