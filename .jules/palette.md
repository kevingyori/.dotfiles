## 2024-04-26 - Contextual Empty States
**Learning:** Contextual empty states improve usability by clarifying whether the list is completely empty or just filtered. Adjusting the blank space filler loop accounts for rendered message lines to prevent layout jumping in paginated Bubble Tea TUIs.
**Action:** Implement differentiated empty states based on context (search vs overall empty) and set numRendered appropriately.
