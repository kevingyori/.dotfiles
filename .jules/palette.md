## 2024-05-18 - Contextual Empty States in TUI
**Learning:** In TUI applications, empty state messaging should be contextually differentiated to clarify whether the overall list is completely empty versus when a search filter simply yields no results. Also, blank space filler loops must be adjusted to account for rendered message lines to prevent layout jumping and preserve exact pagination height.
**Action:** Always implement context-aware empty states in paginated lists and adjust spacing loops accordingly to maintain consistent UI layout.
