
## 2026-04-06 - [Contextual Empty States]
**Learning:** In TUI applications, a completely blank screen when a list is empty or search returns no results causes confusion. Differentiated empty states ("No items managed" vs. "No items match your search") clarify the system state immediately.
**Action:** Always implement contextual empty states in lists/tables, and adjust rendering filler loops to account for the space taken by the empty state message to prevent layout jumping.
