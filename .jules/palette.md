## 2024-05-24 - Add contextual empty states to TUI list
**Learning:** In paginated Bubble Tea TUI views, empty state messaging should be contextually differentiated (e.g., completely empty vs. no search results) and the blank space filler loop must account for the rendered message lines to prevent layout jumping and preserve exact pagination height.
**Action:** Ensure contextual messaging for empty lists and adjust blank space filler logic (e.g., `numRendered = 1`) when rendering empty states in Bubble Tea TUI apps.
