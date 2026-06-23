## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Redundant String Allocations in TUI Filter Loop
**Learning:** While Go's `strings.ToLower` has a fast path, calling it redundantly inside a hot loop (e.g., filtering) on strings already normalized upon insertion causes measurable performance overhead. Trust normalized internal states to avoid unnecessary processing in tight loops.
**Action:** Avoid calling `strings.ToLower` on already normalized domain properties during search filtering to reduce allocations and CPU overhead per keystroke.
