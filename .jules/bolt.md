## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Redundant strings.ToLower in Hot Loops
**Learning:** `strings.ToLower` has measurable performance overhead when called redundantly inside hot loops (like filtering logic), especially in Go where domain normalization can be done once upon insertion.
**Action:** Always trust normalized internal states (like domains which are lowercased on `Add`) and avoid unnecessary string manipulations inside loop condition checks.
