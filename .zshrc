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

autoload -U compinit colors vcs_info
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

zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':vcs_info:*' stagedstr '%F{green}●%f '
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f '
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{blue}%b%f %u%c"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # colorize completion lists
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

_setup_ps1() {
  vcs_info
  GLYPH="▲"
  [ "x$KEYMAP" = "xvicmd" ] && GLYPH="▼"
  PS1=" %(?.%F{blue}.%F{red})$GLYPH%f %(1j.%F{cyan}[%j]%f .)%F{blue}%~%f %(!.%F{red}#%f .)"
  RPROMPT="$vcs_info_msg_0_"
}
_setup_ps1

# vi mode
# zle-keymap-select () {
#  _setup_ps1
#   zle reset-prompt
# }
# zle -N zle-keymap-select
# zle-line-init () {
#   zle -K viins
# }
# zle -N zle-line-init
# bindkey -v

# Common emacs bindings for vi mode
# bindkey '\e[3~'   delete-char
# bindkey '^A'      beginning-of-line
# bindkey '^E'      end-of-line
# bindkey '^R'      history-incremental-pattern-search-backward
# Tmux home/end
# bindkey '\e[1~'      beginning-of-line
# bindkey '\e[4~'      end-of-line

# user-friendly command output
export CLICOLOR=1
ls --color=auto &> /dev/null && alias ls='ls --color=auto'

# Load NVM (Node Version Manager) which gives us node, npm, and yarn
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Load Angular CLI autocompletion.
source <(ng completion script)
export PATH="$PATH:/home/james/.dotnet/tools"
