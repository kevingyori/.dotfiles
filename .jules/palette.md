## 2025-03-08 - Empty States in Paginated TUIs
**Learning:** In paginated Bubble Tea TUI views, when rendering an empty state message, you must adjust the blank space filler loop (e.g., `numRendered = 1`) to account for the rendered message lines. This prevents layout jumping and preserves the exact pagination height. Also, empty states should provide contextual messaging (e.g., general empty vs. search empty).
**Action:** Always include empty states with helpful call-to-actions, and ensure they calculate and consume the exact number of lines expected by the layout filler loops.
