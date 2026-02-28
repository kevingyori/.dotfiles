## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI Render Bottlenecks
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), `View()` and `Update()` loops can fire very frequently. Deep slice copies inside these frequent loops cause an O(N) memory allocation per render tick, leading to high garbage collection overhead.
**Action:** Avoid deep slice copies in frequent loops. Prefer returning direct slice references for read-only operations to prevent O(N) memory allocations per render tick.
