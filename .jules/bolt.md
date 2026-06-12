## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2024-06-12 - Redundant Normalization in UI Loops
**Learning:** `strings.ToLower` in hot filtering loops on already-normalized strings (like `d.Name`) causes measurable performance overhead.
**Action:** Trust normalized internal states to avoid unnecessary processing and allocations in tight loops.
