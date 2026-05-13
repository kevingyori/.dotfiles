## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2024-05-13 - Avoid deep slice copies in frequent TUI rendering loops
**Learning:** In Bubble Tea apps, returning deep copies of slices (via `Get()`) in frequently called view/update loops leads to O(N) memory allocations per tick, significantly degrading performance.
**Action:** Introduce and use zero-allocation methods like `Items()` to return direct slice references for read-only operations, while preserving `Get()` for asynchronous operations to avoid data races.
