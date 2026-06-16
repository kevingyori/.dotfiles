## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Redundant Normalization in Hot Loops
**Learning:** Go's `strings.ToLower` has a fast path, but calling it redundantly inside a hot loop (like filtering) on strings that were already normalized upon insertion causes measurable performance overhead.
**Action:** Trust normalized internal states and perform normalization exclusively at the system boundaries (e.g., during insertion) to avoid unnecessary processing in tight loops.
