## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2024-05-15 - [Bubble Tea TUI Render Loops]
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), creating deep slice copies in frequent loops (e.g., View or Update rendering) causes O(N) memory allocations per render tick.
**Action:** Prefer returning direct slice references for read-only operations to prevent unnecessary memory allocations and CPU overhead during fast render cycles.
