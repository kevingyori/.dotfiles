typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.local/scripts"
  "$HOME/.local/share/bob/nvim-bin"
  "$HOME/go/bin"
  "$HOME/.yarn/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/mysql-client/bin"
  "/opt/homebrew/opt/fzf/bin"
  "/Applications/Ghostty.app/Contents/MacOS"
  $path
)

export EDITOR=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export GOPATH="$HOME/go"
export HOMEBREW_NO_AUTO_UPDATE=1
. "$HOME/.cargo/env"
