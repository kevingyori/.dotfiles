## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2024-05-24 - Avoid redundant string normalization in hot loops
**Learning:** While Go's `strings.ToLower` is fast, calling it redundantly inside a hot loop (like a filter function) on strings that are already normalized upon insertion causes measurable overhead (allocations and CPU time). Trusting the normalized internal state avoids unnecessary processing in tight loops.
**Action:** Always check the data ingestion path (like `Add` or `Insert` methods) to see if data is already normalized before applying formatting functions like `ToLower` in read-heavy paths or loops.
