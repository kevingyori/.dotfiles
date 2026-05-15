## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Slice copying in UI renders
**Learning:** In Go UI loops (like Bubble Tea), returning deep slice copies (`Get()`) causes an O(N) allocation penalty per view frame.
**Action:** Use direct slice references (`Items()`) for read-only UI loops to achieve O(1) time and memory, but maintain deep copies (`Get()`) for asynchronous file writes to prevent data races.
