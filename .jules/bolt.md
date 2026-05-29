## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2026-05-29 - TUI Bubble Tea Memory Allocations
**Learning:** In Bubble Tea TUI applications, repeatedly using defensive deep copies (like `Get()`) during frequent UI updates and event loops causes excessive memory allocations and GC pressure.
**Action:** Expose a zero-allocation read-only reference (like `Items()`) for safe use in read-only UI loops, reserving deep copies strictly for state modifications or async commands to avoid data races.
