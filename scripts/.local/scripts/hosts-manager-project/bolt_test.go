package main

import "testing"

func TestDomainList_View(t *testing.T) {
	dl := NewDomainList()
	dl.Add("example.com")

	view := dl.View()
	if len(view) != 1 {
		t.Fatalf("Expected len 1, got %d", len(view))
	}

	dl.Toggle("example.com")
	if !view[0].Blocked {
		t.Fatalf("View should reflect in-place modifications")
	}
}
