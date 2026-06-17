## 2025-02-24 - Zsh Startup Bottlenecks
**Learning:** `$(brew --prefix)` is a major performance killer during shell startup because it spawns Ruby. On modern systems, Homebrew paths are predictable (`/opt/homebrew`, `/usr/local`, etc.).
**Action:** Always prefer static directory checks over dynamic `brew --prefix` calls in shell configuration. Use `brew --prefix` only as a fallback.

## 2025-02-24 - Expensive init scripts
**Learning:** Using `eval "$(command init zsh)"` (like zoxide, rbenv) is a major performance killer during shell startup because it spawns a new process to generate static script code on every startup.
**Action:** Cache the output of these initialization commands to a file and `source` the file instead. Use anonymous functions `() { ... }` to keep the scope clean.

## 2025-02-24 - Cache Invalidation
**Learning:** Hard-caching initialization scripts without invalidation breaks functionality when tools upgrade, and relying on `~/.cache` without checking if it exists throws errors on fresh systems.
**Action:** Always ensure the parent cache directory exists (`mkdir -p`) and use shell timestamp checking (`-nt`) to invalidate the cache when the binary itself updates.
