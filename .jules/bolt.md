## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.
## 2025-05-30 - Bubble Tea Zero-Allocation Slice Reads
**Learning:** In Go Bubble Tea applications, passing deep copies of lists to UI rendering and basic updates creates unnecessary O(N) heap allocations on every keypress. However, passing direct references to asynchronous commands (`tea.Cmd`) can cause data races if the UI concurrently modifies the slice.
**Action:** Expose two methods for slice access: `Items()` which returns a zero-allocation read-only reference for UI loops/rendering, and `Get()` which returns a safe deep copy strictly for passing into asynchronous `tea.Cmd` operations.
