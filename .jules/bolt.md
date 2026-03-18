## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-25 - Go Bubble Tea Async Cmd Slice Data Races
**Learning:** Passing a direct reference to a slice to asynchronous commands (`tea.Cmd`) like saving to a file causes a data race when the TUI concurrently updates or accesses the slice.
**Action:** Always pass a deep copy of slices (using a `Clone()` method) when passing data from the TUI to `tea.Cmd` tasks. For fast, read-only UI render loops, returning a direct slice reference is highly optimized to avoid O(N) memory allocations per tick.
