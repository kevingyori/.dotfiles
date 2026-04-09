## 2025-04-09 - Differentiated empty states and layout stability
**Learning:** In TUI applications, empty states should be contextually differentiated (e.g., search empty vs overall empty) to provide clarity. Additionally, in paginated views, rendering these empty messages requires adjusting the blank space filler loop (e.g., setting `numRendered = 1`) to preserve the exact pagination height and prevent layout jumping.
**Action:** Always implement contextual empty states in TUIs and adjust filler loops to account for rendered message lines.
