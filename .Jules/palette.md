## 2026-02-20 - [Trust Through Feedback]
**Learning:** Terminal actions like "config reload" are invisible. Users often press the key multiple times just to be sure. Adding a simple confirmation message ("Config reloaded 🚀") builds immediate trust and removes cognitive load.
**Action:** Always add visual feedback (toast, status message, or color change) to invisible system actions.

## 2026-03-12 - [Unsaved State Visibility]
**Learning:** In TUI applications, users can easily lose track of unsaved modifications because visual cues are often minimal compared to GUI apps. A persistent "Unsaved" indicator prevents data loss and builds confidence.
**Action:** Always implement a clear visual indicator (e.g., `*` or `[Unsaved]`) for dirty states in TUI forms or editors.

## 2026-02-22 - [Preserving Context in TUI]
**Learning:** In TUI applications, replacing the entire screen for a simple input or confirmation destroys context. Users forget what they were acting on (e.g., "Was I deleting 'google.com' or 'google-analytics.com'?"). Keeping the list visible while showing the input/dialog at the bottom feels much more grounded and less disorienting.
**Action:** Avoid full-screen mode switches for simple transient tasks in TUIs. Overlay or append UI elements instead.
## 2026-06-04 - [Contextual Empty States in Paginated TUIs]
**Learning:** In TUI applications with paginated views, an empty state (e.g., no items found in search) can cause layout jumping if the space filler loop doesn't account for the rendered empty state message. Also, generic empty states cause confusion; differentiating between "no items" vs "no items match search" improves clarity.
**Action:** Always provide context-aware empty state messages and explicitly account for their rendered line count in pagination/layout filler loops to prevent UI jumping.
