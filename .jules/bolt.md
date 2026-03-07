## 2025-03-07 - Avoid Deep Slice Copies in TUI Applications
**Learning:** In Go Bubble Tea TUI applications (like hosts-manager), deep slice copies in frequent loops (e.g., View or Update rendering) can lead to O(N) memory allocations per render tick, causing unnecessary overhead.
**Action:** Prefer returning direct slice references for read-only operations (e.g., `Items() []Domain`) instead of deep copying slices (e.g., `Get() []Domain`), unless mutation is expected, to prevent memory churn.
