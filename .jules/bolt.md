## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-06-01 - Zero-Allocation Slices in Bubble Tea UI Loops
**Learning:** Continuously calling methods that perform deep copies of arrays during Bubble Tea's render or interaction loops (like `Update` and `View`) causes significant garbage collection overhead.
**Action:** Use direct, zero-allocation slice references (like `Items()`) for read-only UI loops, and reserve deep-copy methods (like `Get()`) strictly for asynchronous updates (`tea.Cmd`) where data races are a risk.
