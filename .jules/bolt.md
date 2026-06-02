## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-02-24 - Redundant String Lowercasing
**Learning:** `strings.ToLower` was called repeatedly inside a filter loop on domain names that were already lowercased upon addition, causing measurable performance overhead (approx ~30% slower) due to redundant checks and potential string allocations.
**Action:** Trust normalized internal states and avoid redundant processing in loops (e.g., lowercasing) for data that is enforced strictly upon insertion.
