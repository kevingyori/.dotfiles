## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-14 - Bubble Tea TUI Array Reallocation
**Learning:** Deep copying arrays or slices frequently in TUI update/view loops causes significant O(N) memory allocations per render tick, hurting responsiveness.
**Action:** For read-only operations (like UI updates), return direct slice references. Only use deep copies (`Clone()`) when passing state to asynchronous commands (`tea.Cmd`) to prevent data races.
