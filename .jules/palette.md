## 2025-03-12 - TUI Empty States

**Learning:** In TUI applications with paginated views, missing empty states can confuse users into thinking the app is broken. Empty state messaging should be contextually differentiated to clarify whether the overall list is completely empty (e.g., 'No domains managed yet') versus when a search filter simply yields no results (e.g., 'No domains match your search').
**Action:** When rendering an empty state message, adjust the blank space filler loop to account for the rendered message lines (e.g., set `numRendered = 1`) to prevent layout jumping and preserve exact pagination height.
