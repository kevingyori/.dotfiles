## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-03-12 - Bubble Tea TUI Slice Copies and Data Races
**Learning:** Returning deep copies of slices in frequent TUI loops (like `View()` or `Update()`) causes excessive O(N) memory allocations per render tick. However, passing direct slice references to asynchronous commands (`tea.Cmd`) can cause data races if the UI concurrently modifies the slice.
**Action:** In Go Bubble Tea applications, prefer returning direct slice references for read-only operations to prevent memory allocation overhead in render loops. Always pass explicit deep copies (`Clone()`) to asynchronous commands to guarantee thread safety.
