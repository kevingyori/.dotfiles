package main

import (
	"os"
	"testing"
)

func TestUIModel_DirtyState(t *testing.T) {
	// Setup a temporary hosts file for the HostsManager
	tmpFile, err := os.CreateTemp("", "ui_test_hosts")
	if err != nil {
		t.Fatalf("Failed to create temp file: %v", err)
	}
	defer os.Remove(tmpFile.Name())

	hm := NewHostsManager(tmpFile.Name())
	ui := NewUIModel(hm)

	// Initial state should be clean
	if ui.IsDirty() {
		t.Error("New UIModel should be clean")
	}

	// AddDomain should make it dirty
	ui.AddDomain("example.com")
	if !ui.IsDirty() {
		t.Error("AddDomain should make UI dirty")
	}

	// SetClean should make it clean
	ui.SetClean()
	if ui.IsDirty() {
		t.Error("SetClean should make UI clean")
	}

	// ToggleSelectedDomain should make it dirty
	// First we need a selected domain. AddDomain adds it.
	ui.AddDomain("example.com")
	ui.SetClean() // reset
	ui.ToggleSelectedDomain()
	if !ui.IsDirty() {
		t.Error("ToggleSelectedDomain should make UI dirty")
	}

	// DeleteSelectedDomain should make it dirty
	ui.SetClean() // reset
	ui.DeleteSelectedDomain()
	if !ui.IsDirty() {
		t.Error("DeleteSelectedDomain should make UI dirty")
	}

	// SetDomains should make it clean (simulating load)
	ui.AddDomain("dirty.com")
	if !ui.IsDirty() {
		t.Error("Should be dirty before SetDomains")
	}
	ui.SetDomains([]Domain{})
	if ui.IsDirty() {
		t.Error("SetDomains should make UI clean")
	}
}
