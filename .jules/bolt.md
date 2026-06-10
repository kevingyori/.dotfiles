## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Unnecessary String Allocation in Hot Loops
**Learning:** Redundant `strings.ToLower` calls inside hot loops (like filtering logic) on data that is already normalized upon insertion creates unnecessary allocations and measurable performance overhead.
**Action:** Trust normalized internal states. Avoid redundant processing in tight loops by ensuring data is normalized once during insertion.
