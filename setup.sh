#!/usr/bin/env bash
set -euo pipefail

if ! command -v stow >/dev/null 2>&1; then
  echo "stow is not installed yet; will install via Homebrew." >&2
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$repo_root"

if [ "$#" -ne 0 ]; then
  echo "This setup script does not take package names." >&2
  exit 2
fi

if ! xcode-select -p >/dev/null 2>&1; then
  echo "Xcode Command Line Tools are required. Running xcode-select --install..." >&2
  xcode-select --install
  echo "Re-run this script after the installer completes." >&2
  exit 2
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found; installing..." >&2
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew update

if [ -f "$repo_root/Brewfile" ]; then
  brew bundle --file "$repo_root/Brewfile"
fi

stow -t "$HOME" */
