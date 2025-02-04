export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
    npm
    node
    yarn
)
source $ZSH/oh-my-zsh.sh

autoload -Uz compinit vcs_info
colors
compinit

REPORTTIME=3
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt CORRECT

HIST_STAMPS="yyyy-mm-dd"
alias history='fc -il 1'
alias h='fc -il 1 | less'

function hs() {
    history | grep --color=auto "$@"
}

# Completion configuration
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # colorize completion lists
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# Enhanced git status configuration
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{red}●%f'    # Red dot for unstaged changes
zstyle ':vcs_info:git:*' stagedstr '%F{green}●%f'    # Green dot for staged changes
zstyle ':vcs_info:git:*' formats '%F{blue}(%b)%f %u%c%m' # Branch name in parentheses
zstyle ':vcs_info:git:*' actionformats '%F{blue}(%b|%a)%f %u%c%m' # Also show action (rebase/merge)
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked # Enable untracked files check

# Function to check for untracked files
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -m 1 '^??' &>/dev/null
    then
        hook_com[misc]='%F{yellow}●%f' # Yellow dot for untracked files
    fi
}

# Update vcs_info before each prompt
precmd_functions+=( vcs_info )

# Setup prompt
_setup_ps1() {
  GLYPH="▲"
  [ "x$KEYMAP" = "xvicmd" ] && GLYPH="▼"
  PS1=" %(?.%F{blue}.%F{red})$GLYPH%f %(1j.%F{cyan}[%j]%f .)%F{blue}%~%f \${vcs_info_msg_0_} %(!.%F{red}#%f .)"
}
_setup_ps1

# Make sure prompt updates with each command
precmd_functions+=( _setup_ps1 )

export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto'

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load Angular CLI autocompletion.
source <(ng completion script)
export PATH="$PATH:/home/james/.dotnet/tools"