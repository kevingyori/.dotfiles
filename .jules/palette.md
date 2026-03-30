## 2024-05-15 - Empty State Alignment in TUI Pagination
**Learning:** In paginated Bubble Tea TUI views, rendering an empty state message takes up a line of text. If the blank space filler loop isn't adjusted to account for this (e.g., setting `numRendered = 1`), the layout will jump, breaking the exact pagination height.
**Action:** Always adjust filler loops in paginated TUIs when rendering empty state messages to preserve consistent layout height.
