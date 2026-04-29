## 2026-02-20 - [Trust Through Feedback]
**Learning:** Terminal actions like "config reload" are invisible. Users often press the key multiple times just to be sure. Adding a simple confirmation message ("Config reloaded 🚀") builds immediate trust and removes cognitive load.
**Action:** Always add visual feedback (toast, status message, or color change) to invisible system actions.

## 2026-03-12 - [Unsaved State Visibility]
**Learning:** In TUI applications, users can easily lose track of unsaved modifications because visual cues are often minimal compared to GUI apps. A persistent "Unsaved" indicator prevents data loss and builds confidence.
**Action:** Always implement a clear visual indicator (e.g., `*` or `[Unsaved]`) for dirty states in TUI forms or editors.

## 2026-02-22 - [Preserving Context in TUI]
**Learning:** In TUI applications, replacing the entire screen for a simple input or confirmation destroys context. Users forget what they were acting on (e.g., "Was I deleting 'google.com' or 'google-analytics.com'?"). Keeping the list visible while showing the input/dialog at the bottom feels much more grounded and less disorienting.
**Action:** Avoid full-screen mode switches for simple transient tasks in TUIs. Overlay or append UI elements instead.

## 2026-04-29 - [Contextual Empty States in TUI]
**Learning:** In TUI applications, missing empty states can leave the user confused whether a list is empty or a search yielded no results. Additionally, rendering empty state messages without adjusting the blank space filler loop can cause layout jumping and break exact pagination heights.
**Action:** Always provide contextually differentiated empty states (e.g., 'No items managed yet' vs 'No items match your search') and adjust filler loops to account for rendered message lines (e.g., set `numRendered = 1`) to preserve pagination height.
