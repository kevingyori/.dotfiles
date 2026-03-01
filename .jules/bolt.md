## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2026-03-01 - TUI Memory Allocations in Go
**Learning:** In Go Bubble Tea applications, deep slice copies in frequent loops (e.g., View or Update) can cause significant GC pressure and O(N) memory allocations per render tick.
**Action:** Avoid deep slice copies and prefer returning direct slice references for read-only operations to improve rendering performance and reduce memory usage.
