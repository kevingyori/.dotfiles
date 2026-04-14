## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-04-14 - Zero-Allocation TUI Rendering Loops
**Learning:** In Go Bubble Tea applications, deep slice copies (e.g., returning copies from a DomainList) during frequent loop iterations like View() or Update() cause unnecessary O(N) memory allocations per render tick.
**Action:** Expose an Items() method that returns a direct slice reference for read-only UI loops, and reserve Get() for asynchronous tea.Cmd operations where deep copies are necessary for safety.
