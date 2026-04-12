## 2024-04-12 - Empty State Layout Shifts
**Learning:** In paginated views, rendering empty state messages without adjusting the filler loop causes layout jumping.
**Action:** Always adjust the filler loop (e.g., set numRendered = 1) when rendering empty states.
