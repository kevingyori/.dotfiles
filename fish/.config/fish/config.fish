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

###-begin-pnpm-completion-###
function _pnpm_completion
    set cmd (commandline -o)
    set cursor (commandline -C)
    set words (count $cmd)

    set completions (eval env DEBUG=\"" \"" COMP_CWORD=\""$words\"" COMP_LINE=\""$cmd \"" COMP_POINT=\""$cursor\"" SHELL=fish pnpm completion-server -- $cmd)

    if [ "$completions" = __tabtab_complete_files__ ]
        set -l matches (commandline -ct)*
        if [ -n "$matches" ]
            __fish_complete_path (commandline -ct)
        end
    else
        for completion in $completions
            echo -e $completion
        end
    end
end

complete -f -d pnpm -c pnpm -a "(_pnpm_completion)"
###-end-pnpm-completion-###



# bun start
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun end

set -gx EDITOR nvim

export HOMEBREW_NO_AUTO_UPDATE=1

# Fix cursor shape in the shell
# Only run this in interactive shells
if status is-interactive

    # I'm trying to grow a neckbeard
    # fish_vi_key_bindings
    # Set the cursor shapes for the different vi modes.
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_visual block

    function fish_user_key_bindings
        # Execute this once per mode that emacs bindings should be used in
        fish_default_key_bindings -M insert
        fish_vi_key_bindings --no-erase insert
    end
end

starship init fish | source

# # Base16 Shell
# if status --is-interactive
#     set BASE16_SHELL_PATH "$HOME/.config/base16-shell"
#     if test -s "$BASE16_SHELL_PATH"
#         source "$BASE16_SHELL_PATH/profile_helper.fish"
#     end
# end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# Go
set -x PATH /Users/kevingyori/go/bin "$PATH"

# Added by `rbenv init` on Sun  2 Feb 2025 19:36:23 GMT
status --is-interactive; and rbenv init - --no-rehash fish | source

# Added by Windsurf
fish_add_path /Users/kevingyori/.codeium/windsurf/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/kevingyori/.lmstudio/bin
# End of LM Studio CLI section

