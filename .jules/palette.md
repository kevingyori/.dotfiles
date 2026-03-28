## 2024-03-28 - TUI Empty States
**Learning:** In TUI applications, empty states should provide context. Distinguishing between a generic empty list ("No items managed yet") and an empty search result ("No items match your search") provides necessary guidance.
**Action:** Always differentiate empty states and use the correct placeholder text, making sure to adjust the blank space filler loop (like `numRendered`) to prevent layout jumping.
