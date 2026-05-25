	for i, d := range paginatedDomains {
		cursor := " "
		if m.ui.cursor == i {
			cursor = ">"
		}
		checkbox := "[ ]"
		if d.Blocked {
			checkbox = selectedStyle.Render("[✔]")
		}
		row := fmt.Sprintf("%s %s %s", cursor, checkbox, d.Name)
		if m.ui.cursor == i {
			b.WriteString(cursorStyle.Render(row) + "\n")
		} else {
			b.WriteString(row + "\n")
		}
	}

	// Fill remaining space
	numRendered := len(paginatedDomains)
	for i := numRendered; i < m.ui.paginator.PerPage; i++ {
		b.WriteString("\n")
	}
