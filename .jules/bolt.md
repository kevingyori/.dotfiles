## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Redundant String Operations in Hot Loops
**Learning:** Calling `strings.ToLower` repeatedly on strings that are already normalized upon creation/insertion introduces measurable performance overhead in hot loops (like filtering logic). Trusting the internal normalized state prevents unnecessary string allocations and processing, yielding ~3x speedup in this codebase's benchmarks.
**Action:** Ensure data is normalized once at the boundary (e.g., during insertion or API receipt) and avoid redundant normalization checks in frequent read/filter paths.
