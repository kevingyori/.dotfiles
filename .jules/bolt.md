## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Redundant string operations in hot loops
**Learning:** Calling `strings.ToLower` on already-normalized internal state (`d.Name`) inside a tight filtering loop causes massive overhead (approx 2.5x slower). Trust normalized internal states to avoid unnecessary processing in hot loops.
**Action:** When filtering or processing collections, ensure normalization happens once on ingestion (e.g., `Add`), not repeatedly during reads (e.g., `Filter`).
