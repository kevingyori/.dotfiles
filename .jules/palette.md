## 2024-04-18 - TUI Empty States Guidance
**Learning:** In TUI applications like hosts-manager, missing empty states should be replaced with helpful guidance and call-to-actions to improve usability. Differentiating between overall empty lists and empty search results provides clearer context to the user.
**Action:** When implementing paginated lists in TUI apps, always provide an empty state message and adjust the blank space filler loop (e.g., set `numRendered = 1`) to account for the rendered message lines and prevent layout jumping.
