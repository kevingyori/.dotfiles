## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Redundant Normalization in Hot Loops
**Learning:** Calling `strings.ToLower` redundantly inside a hot loop (e.g., UI filtering) on strings that are already normalized upon insertion causes measurable performance overhead due to repeated allocations and checks.
**Action:** Trust normalized internal states to avoid unnecessary processing in tight loops. Validate data at the boundary (e.g., `Add()`), not during read-heavy operations.
