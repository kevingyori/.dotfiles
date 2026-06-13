## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-12 - Redundant Normalization in Hot Loops
**Learning:** Calling `strings.ToLower` on already normalized strings inside a filtering hot loop causes a ~3.6x performance overhead (from ~165µs to ~596µs per 10k domains). Trusting normalized internal states avoids unnecessary processing.
**Action:** Always verify if strings in internal collections are already normalized before applying transformations like `ToLower` in hot loops (e.g., search/filter).
