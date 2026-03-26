## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Bubble Tea TUI Slice Memory Allocation and Data Races
**Learning:** In Go Bubble Tea TUI applications, returning deep slice copies (e.g., `Get()`) in frequent read operations (like UI View or Update loops) causes severe O(N) memory allocations per render tick. However, passing direct slice references to asynchronous commands (`tea.Cmd`) can cause data races if the UI concurrently modifies the slice.
**Action:** Optimize by returning direct slice references for frequent read-only UI operations to prevent memory allocation, but implement a separate `Clone()` method to provide deep copies strictly for asynchronous operations (`tea.Cmd`) to prevent data races.
