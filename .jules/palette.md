## 2024-04-03 - Empty States in TUI
**Learning:** In TUI applications, empty state messaging should be contextually differentiated (e.g. overall list empty vs search empty) and when rendering, the blank space filler loop must account for the rendered message lines to prevent layout jumping.
**Action:** Implemented contextual empty states in hosts-manager that distinguish between no domains and no search results, and adjusted `numRendered` to preserve exact pagination height.
