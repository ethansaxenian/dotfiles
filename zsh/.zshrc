export DOTFILES=$HOME/.dotfiles

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_BIN_HOME="$HOME/.local/bin"

export EDITOR="nvim"
export VISUAL="nvim"

export GOPATH="$HOME/go"

export MANPAGER='nvim +Man!'

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_COLORS=Bmgre
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
fi

# add my own executables to $PATH
path=(
  "$HOME/.local/bin"
  "$DOTFILES/bin"
  "$GOPATH/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "/opt/homebrew/opt/libpq/bin"
  $path
)

fpath=(
  "$(brew --prefix)/share/zsh/site-functions"
  $fpath
)

# remove uniques from $PATH and $FPATH
typeset -aU path
typeset -aU fpath


# enable aliases to be sudo'ed
alias sudo="sudo "

alias vim="$EDITOR"

# opens the zsh config file for editing
alias config="vim $DOTFILES/zsh/.zshrc"

alias vconfig="nvim $DOTFILES/nvim/init.lua"

# reloads the terminal
alias reload="source $HOME/.zshrc"

alias grep="grep --color=auto -E"

# Make shell handle commands containing a leading $
alias "$"="$@"

# defaults for common commands
alias cp="nocorrect cp -iv"
alias mv="nocorrect mv -iv"
alias rm="rm -Iv"
alias mkd="mkdir -pv"

export FZF_DEFAULT_OPTS='
--height=100%
--border
--layout=default
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
--bind="alt-k:preview-up,alt-j:preview-down,ctrl-w:toggle-preview-wrap"
--preview-window="border-left"
--pointer=">"
--marker=">"
'

export FD_OPTIONS="--ignore --hidden --follow --strip-cwd-prefix"
export FZF_DEFAULT_COMMAND="fd --type file $FD_OPTIONS --no-ignore-vcs"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_COMMAND="fd --type directory $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {}' --bind 'ctrl-/:change-preview-window(hidden|)'"

export FZF_CTRL_R_OPTS="
--preview 'echo {}'
--preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
"

# Options to fzf command
export FZF_COMPLETION_OPTS="$FZF_DEFAULT_OPTS --height=100% --layout=default"

# Use fd instead of the default find command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  eval "fd $1 --type file $FD_OPTIONS"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  eval "fd $1 --type directory $FD_OPTIONS"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    export|unset)       fzf "$@" --preview "eval 'echo \$'{}" ;;
    unalias)            fzf "$@" --preview 'echo $(alias {})' ;;
    ssh)                fzf "$@" --preview 'nslookup {}' ;;
    cd)                 fzf "$@" --preview "tree -C {}" ;;
    nvim|vim)           fzf "$@" --preview "bat --style=numbers --color=always {}" ;;
    *)                  fzf "$@" ;;
  esac
}


alias activate="source .venv/bin/activate"

eval $(dircolors $DOTFILES/zsh/LS_COLORS)
alias ls="ls --color=auto -Fh"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"


alias ga="git add -A"
alias gac="git add -A && git commit -m"
alias gbd="git branch -D"
alias gc="git commit -m"
alias gd="git diff --color | sed 's/^\([^-+ ]*\)[-+ ]/\\1/' | less -RFX"
alias gf="git fetch"
alias gl="git pull --prune"
alias grst="git reset ."
alias gp="git push"
alias gpu="git push -u origin"
alias gs="git status -sb"
alias gst="git stash -u"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsw="git switch"




function collapse_pwd() {
  echo "%(5~|%-1~/.../%3~|%4~)"
}

PROMPT="%B%F{magenta}$(collapse_pwd)%f%b %# "

# }}}
# shell options {{{
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=5000
export HISTSIZE=5000

setopt NO_CASE_GLOB
setopt AUTO_CD
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
# ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt CORRECT
setopt CORRECT_ALL

# }}}
# completion {{{

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"


if test $(command -v fzf); then
  source <(fzf --zsh)
fi

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# vi-mode
bindkey -v
export KEYTIMEOUT=1

# ctrl-space accepts autosuggestion
bindkey '^y' autosuggest-accept

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey -s '^v' "fzf --bind 'enter:become(nvim {})' $FZF_CTRL_T_OPTS\n"
bindkey -s '^f' 'tmux-sessionizer\n'
bindkey -s '^[t' 'tmux a\n'
