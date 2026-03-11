## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-11 - Bubble Tea Slice Allocations
**Learning:** In Go Bubble Tea applications, deep-copying slices during frequent `Update` or `View` render ticks causes excessive O(N) memory allocations and GC pressure. Returning direct references is safe for read-only rendering.
**Action:** Use direct slice references for UI state rendering, but preserve deep copies for asynchronous commands (`tea.Cmd`) to avoid concurrency data races.
