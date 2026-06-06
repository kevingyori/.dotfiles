## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Redundant Normalization in Hot Loops
**Learning:** The hosts-manager normalizes domains upon insertion but redundantly re-normalizes them with `strings.ToLower` inside the `Filter` loop, creating a measurable performance overhead (~2.3x slower) during searches.
**Action:** Trust normalized internal state and avoid redundant processing like `strings.ToLower` in tight loops when data is already normalized at creation.
