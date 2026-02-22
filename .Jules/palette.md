## 2026-02-20 - [Trust Through Feedback]
**Learning:** Terminal actions like "config reload" are invisible. Users often press the key multiple times just to be sure. Adding a simple confirmation message ("Config reloaded 🚀") builds immediate trust and removes cognitive load.
**Action:** Always add visual feedback (toast, status message, or color change) to invisible system actions.

## 2026-02-22 - [Preserving Context in TUI]
**Learning:** In TUI applications, replacing the entire screen for a simple input or confirmation destroys context. Users forget what they were acting on (e.g., "Was I deleting 'google.com' or 'google-analytics.com'?"). Keeping the list visible while showing the input/dialog at the bottom feels much more grounded and less disorienting.
**Action:** Avoid full-screen mode switches for simple transient tasks in TUIs. Overlay or append UI elements instead.
