## 2024-10-24 - Contextual Empty States in TUIs
**Learning:** In Bubble Tea paginated lists, rendering an empty state requires carefully adjusting the blank space filler loop (e.g., setting numRendered = 1 for a single-line empty message) to preserve exact pagination height and prevent jarring layout jumping. Missing items should be differentiated by search vs. overall emptiness.
**Action:** Always implement empty states with contextual guidance, and always manually adjust filler loops when substituting list items with empty state messages.
