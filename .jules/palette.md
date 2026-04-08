## 2024-03-24 - Preserving Pagination Height in Bubble Tea
**Learning:** When adding empty state messages to paginated list views in Bubble Tea TUIs, rendering the message consumes lines that the empty space filler loop normally expects to fill.
**Action:** Always adjust the `numRendered` count (e.g., set to 1 for a single-line message) when displaying empty states to prevent layout jumping and maintain exact pagination height.
