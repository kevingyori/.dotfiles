## 2026-02-20 - [Trust Through Feedback]
**Learning:** Terminal actions like "config reload" are invisible. Users often press the key multiple times just to be sure. Adding a simple confirmation message ("Config reloaded 🚀") builds immediate trust and removes cognitive load.
**Action:** Always add visual feedback (toast, status message, or color change) to invisible system actions.

## 2026-03-12 - [Unsaved State Visibility]
**Learning:** In TUI applications, users can easily lose track of unsaved modifications because visual cues are often minimal compared to GUI apps. A persistent "Unsaved" indicator prevents data loss and builds confidence.
**Action:** Always implement a clear visual indicator (e.g., `*` or `[Unsaved]`) for dirty states in TUI forms or editors.

## 2026-02-22 - [Preserving Context in TUI]
**Learning:** In TUI applications, replacing the entire screen for a simple input or confirmation destroys context. Users forget what they were acting on (e.g., "Was I deleting 'google.com' or 'google-analytics.com'?"). Keeping the list visible while showing the input/dialog at the bottom feels much more grounded and less disorienting.
**Action:** Avoid full-screen mode switches for simple transient tasks in TUIs. Overlay or append UI elements instead.

## 2026-03-24 - [Contextual Empty States]
**Learning:** In TUI applications, an empty state could mean "the list is empty" or "no items match the filter". Using a generic empty view, or failing to provide an empty view, leaves users confused. Missing empty states should be replaced with helpful guidance and call-to-actions, and must differentiate between list states to clarify the context.
**Action:** Empty state messaging should be contextually differentiated to clarify whether the overall list is completely empty versus when a search filter simply yields no results.
