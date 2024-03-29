# If not in tmux, start tmux.
# if [[ -z ${TMUX+X}${ZSH_SCRIPT+X}${ZSH_EXECUTION_STRING+X} ]]; then
#   exec tmux attach || exec tmux new-session
# fi

# Quote/Phrase on startup
# fortune -n short | cowsay


# Custom functions
beepboop() {
    # sleep $(echo "$1 * 60" | bc)
    countdown $1
    for x in $(seq 1000); do say "Beep boop"; sleep 0.5; done
}

function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

function refresh-completions() {
  local DIR=$HOME/.local/share/zsh/completions

  # github
  # gh completion -s zsh > $DIR/_gh

}

# Prompt customizations
# PROMPT='► %B%2~%b '
# RPROMPT='$GITSTATUS_PROMPT'  # right prompt: git status

# History config
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt autocd

# Compinstall
# autoload -Uz compinit && compinit
# zstyle :compinstall filename '/Users/kevingyori/.zshrc'


# Clone and compile to wordcode missing plugins.
if [[ ! -e ~/.zsh-plugins/zsh-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-plugins/zsh-syntax-highlighting
  zcompile-many ~/.zsh-plugins/zsh-syntax-highlighting/{zsh-syntax-highlighting.zsh,highlighters/*/*.zsh}
fi
if [[ ! -e ~/.zsh-plugins/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh-plugins/zsh-autosuggestions
  zcompile-many ~/.zsh-plugins/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi
if [[ ! -e ~/.zsh-plugins/zsh-vi-mode ]]; then
  git clone --depth=1 https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh-plugins/zsh-vi-mode
  zcompile-many ~/.zsh-plugins/zsh-vi-mode/{zsh-vi-mode.plugin.zsh,src/**/*.zsh}
fi
if [[ ! -e ~/.zsh-plugins/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh-plugins/powerlevel10k
  make -C ~/.zsh-plugins/powerlevel10k pkg
fi
# https://github.com/hlissner/zsh-autopair
if [[ ! -e ~/.zsh-plugins/zsh-autopair ]]; then
  git clone --depth=1 https://github.com/hlissner/zsh-autopair.git ~/.zsh-plugins/zsh-autopair
  zcompile-many ~/.zsh-plugins/zsh-autopair/{zsh-autopair.plugin.zsh,src/**/*.zsh}
fi
# https://github.com/junegunn/fzf
if [[ ! -e ~/.zsh-plugins/fzf ]]; then
  git clone --depth=1 https://github.com/junegunn/fzf.git ~/.zsh-plugins/fzf
  ~/.zsh-plugins/fzf/install
  # zcompile-many ~/{.fzf.zsh}
fi

# Activate Powerlevel10k Instant Prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# brew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Enable the "new" completion system (compsys).
autoload -Uz compinit && compinit
[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zcompile-many ~/.zcompdump
unfunction zcompile-many

# Case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix

# Completion menu select highlighting
zstyle ':completion:*' menu select

# Tab complete hidden files
_comp_options+=(globdots)

ZSH_AUTOSUGGEST_MANUAL_REBIND=1



# Load plugins
source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ~/.zsh-plugins/zsh-autopair/zsh-autopair.plugin.zsh
source ~/.zsh-plugins/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh-plugins/.p10k.zsh

# FZF fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey '^ ' autosuggest-accept

# Load Aliases
source ~/.zsh_aliases


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/kevingyori/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/kevingyori/miniforge3/etc/profile.d/conda.sh" ]; then
#         . "/Users/kevingyori/miniforge3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/kevingyori/miniforge3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

# Custom completions
fpath=($HOME/.local/share/zsh/completions $fpath)

# decided on using fnm instead of nvm or n
# fnm init
export PATH="/Users/kevingyori/Library/Caches/fnm_multishells/41041_1678174553758/bin":$PATH
export FNM_MULTISHELL_PATH="/Users/kevingyori/Library/Caches/fnm_multishells/41041_1678174553758"
export FNM_LOGLEVEL="info"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_DIR="/Users/kevingyori/Library/Application Support/fnm"
export FNM_ARCH="arm64"
rehash

# bun completions
[ -s "/Users/kevingyori/.bun/_bun" ] && source "/Users/kevingyori/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# java
# export JAVA_HOME=$(/usr/libexec/java_home -v 1.8.0)
export JAVA_HOME=$(/usr/libexec/java_home -v 17.0.6)

# zoxide setup
eval "$(zoxide init zsh)"

# Put the line below in ~/.zshrc:

  # eval "$(jump shell zsh)"

# The following lines are autogenerated:

# __jump_chpwd() {
#   jump chdir
# }

# jump_completion() {
#   reply="'$(jump hint "$@")'"
# }

# j() {
#   local dir="$(jump cd $@)"
#   test -d "$dir" && cd "$dir"
# }

# typeset -gaU chpwd_functions
# chpwd_functions+=__jump_chpwd

# compctl -U -K jump_completion j

# export PATH=/Users/kevingyori/.local/bin:$PATH


# pnpm
export PNPM_HOME="/Users/kevingyori/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export N_PREFIX="$HOME/.n"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
