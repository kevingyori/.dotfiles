## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-08 - Redundant String Normalization in Hot Loops
**Learning:** Calling `strings.ToLower` redundantly inside a hot loop (like real-time filtering) on strings that are already normalized upon insertion causes measurable performance overhead, despite Go's fast paths.
**Action:** Trust normalized internal states. Normalize data once during insertion and avoid redundant conversions in tight loops.
