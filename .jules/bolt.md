## 2025-03-12 - Bubbletea Render Loop Allocations
**Learning:** In Go Bubbletea TUI applications, returning deep slice copies (e.g. `make([]Domain, len(domains)); copy(...)`) in getter methods called during the `Update` or `View` loop causes massive O(N) memory allocations per keystroke or render tick.
**Action:** Use shallow copies or direct slice references (`GetAll() []Domain { return dl.domains }`) for read-only rendering operations to eliminate allocation bottlenecks.

## 2025-03-12 - Go strings.ToLower Fast Path
**Learning:** Go's `strings.ToLower` has an optimized fast path that skips allocation if the string is already lowercase. Removing it under the assumption of a "redundant calculation" yields unmeasurable performance gains and risks introducing functional case-sensitivity regressions.
**Action:** Do not remove `strings.ToLower` for micro-optimization; rely on Go's standard library optimizations unless profiling proves a specific bottleneck.
