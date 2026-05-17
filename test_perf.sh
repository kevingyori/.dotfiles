cd scripts/.local/scripts/hosts-manager-project
cat << 'PATCH' > perf.patch
--- domain.go
+++ domain.go
@@ -66,6 +66,11 @@
	return false
 }

+// Items returns a zero-allocation read-only reference to all domains
+func (dl *DomainList) Items() []Domain {
+	return dl.domains
+}
+
 // Get returns a copy of all domains
 func (dl *DomainList) Get() []Domain {
	result := make([]Domain, len(dl.domains))
@@ -83,7 +88,7 @@
 // Filter returns domains matching the search query
 func (dl *DomainList) Filter(query string) []Domain {
	if query == "" {
-		return dl.Get()
+		return dl.Items()
	}

	query = strings.ToLower(strings.TrimSpace(query))
--- ui.go
+++ ui.go
@@ -83,7 +83,7 @@
	if m.searchInput.Value() != "" {
		return m.filteredDomains
	}
-	return m.domainList.Get()
+	return m.domainList.Items()
 }

 // FilterDomains updates the filtered domains based on search input
@@ -92,7 +92,7 @@
	wasFiltered := len(m.filteredDomains) != m.domainList.Count() && len(m.filteredDomains) > 0

	if searchQuery == "" {
-		m.filteredDomains = m.domainList.Get()
+		m.filteredDomains = m.domainList.Items()
		if wasFiltered {
			m.cursor = 0
		}
@@ -190,7 +190,7 @@
	hadSearchValue := m.searchInput.Value() != ""
	m.searchInput.Reset()
	m.searchInput.Blur()
-	m.filteredDomains = m.domainList.Get()
+	m.filteredDomains = m.domainList.Items()
	m.paginator.SetTotalPages(m.domainList.Count())
	if hadSearchValue {
		m.cursor = 0
@@ -201,7 +201,7 @@
 // SetDomains sets the domain list
 func (m *UIModel) SetDomains(domains []Domain) {
	m.domainList.Set(domains)
-	m.filteredDomains = m.domainList.Get()
+	m.filteredDomains = m.domainList.Items()
	m.paginator.SetTotalPages(len(m.filteredDomains))
	m.dirty = false
	m.statusMsg = "Hosts file loaded."
PATCH
patch -p0 < perf.patch
go test -v $(ls *.go | grep -E -v 'timeout_test.go|hosts-manager')
