package main

import (
	"fmt"
	"testing"
)

func BenchmarkGet(b *testing.B) {
	dl := NewDomainList()
	for i := 0; i < 10000; i++ {
		dl.Add(fmt.Sprintf("domain%d.com", i))
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_ = dl.Get()
	}
}

func BenchmarkGetDirect(b *testing.B) {
	dl := NewDomainList()
	for i := 0; i < 10000; i++ {
		dl.Add(fmt.Sprintf("domain%d.com", i))
	}
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		_ = dl.domains
	}
}
