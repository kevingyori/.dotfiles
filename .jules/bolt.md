## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-04-09 - Go Bubble Tea Deep Slice Copies
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), deep slice copies (e.g. returning copies of slice to UI model per update loop) can trigger excessive memory allocations (O(N) allocations per render tick/update).
**Action:** Avoid deep slice copies in frequent loops (e.g., View or Update rendering). Prefer returning direct slice references for read-only operations to prevent memory spikes.
