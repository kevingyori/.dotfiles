## 2024-05-24 - Empty States in Paginated TUIs
**Learning:** In Bubble Tea TUIs with pagination, empty states need special handling for both messaging and layout. Specifically, differentiated messaging (empty list vs empty search) improves context, and layout loops must account for the empty state message lines (e.g., `numRendered = 1`) to prevent the UI from collapsing or jumping.
**Action:** Always implement empty states with contextual guidance and adjust layout filler loops to account for the message height in paginated views.
