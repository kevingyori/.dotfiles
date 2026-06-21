## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Redundant ToLower in Hot Loops
**Learning:** While Go's `strings.ToLower` is fast, calling it redundantly inside a hot loop (like a search filter) on strings that are already normalized upon insertion causes measurable performance overhead. Relying on normalized internal state is fundamentally faster and reduces allocations.
**Action:** Trust internal state normalization. Remove redundant string manipulation functions in tight loops when the data is guaranteed to be pre-processed correctly.
