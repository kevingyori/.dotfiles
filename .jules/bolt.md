## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2024-06-18 - Remove redundant string allocation in filter loop
**Learning:** In Go, calling `strings.ToLower` inside a hot loop on strings that are already normalized creates unnecessary string allocations and measurable performance overhead.
**Action:** Trust normalized internal states to avoid redundant processing in tight loops like searches/filters.
