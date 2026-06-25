## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2026-06-25 - Redundant String Lowercasing in Go Filter Loops
**Learning:** Calling `strings.ToLower` redundantly inside a hot loop (like a filter function) on strings that are already normalized upon insertion causes measurable performance overhead due to unnecessary allocations.
**Action:** Trust normalized internal state and avoid redundant transformations in tight read-heavy loops.
