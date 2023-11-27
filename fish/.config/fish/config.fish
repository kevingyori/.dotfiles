if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# pnpm
set -gx PNPM_HOME "/Users/kevingyori/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun start
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun end

starship init fish | source
