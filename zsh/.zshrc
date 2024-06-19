# env variables {{{

export EDITOR="nvim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

if [[ $OSTYPE =~ ^darwin ]]; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
  export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
fi

if test -d "$HOME/.detaspace/bin"; then
  export PATH="$HOME/.detaspace/bin:$PATH"
fi

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# colored manpages with bat
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=Monokai\ Extended'"

# }}}
# mac aliases {{{
if [[ $OSTYPE =~ ^darwin ]]; then
  # Empty the Trash on all mounted volumes and the main HDD.
  # Also, clear Apple’s System Logs to improve shell startup speed.
  # Finally, clear download history from quarantine. https://mths.be/bum
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

  alias charm='open -a "PyCharm.app"'
fi
# }}}
# misc aliases {{{

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

# }}}
# fzf {{{

FZF_DEFAULT_OPTS='--height=100%'
FZF_DEFAULT_OPTS+=' --border'
FZF_DEFAULT_OPTS+=' --layout=default'
FZF_DEFAULT_OPTS+=' --color=dark'
FZF_DEFAULT_OPTS+=' --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe'
FZF_DEFAULT_OPTS+=' --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
FZF_DEFAULT_OPTS+=' --bind="alt-k:preview-up,alt-j:preview-down,ctrl-w:toggle-preview-wrap"'
FZF_DEFAULT_OPTS+=' --preview-window="border-left"'
FZF_DEFAULT_OPTS+=' --pointer=">"'
FZF_DEFAULT_OPTS+=' --marker=">"'
export FZF_DEFAULT_OPTS

export FD_OPTIONS="--ignore --hidden --follow --strip-cwd-prefix"
export FZF_DEFAULT_COMMAND="fd --type file $FD_OPTIONS --no-ignore"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_COMMAND="fd --type directory $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {}' --bind 'ctrl-/:change-preview-window(hidden|)'"

FZF_CTRL_R_OPTS="--preview 'echo {}'"
FZF_CTRL_R_OPTS+=" --preview-window up:3:hidden:wrap"
FZF_CTRL_R_OPTS+=" --bind 'ctrl-/:toggle-preview'"
FZF_CTRL_R_OPTS+=" --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
export FZF_CTRL_R_OPTS

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
    vim|v|code|charm)   fzf "$@" --preview "bat --style=numbers --color=always {}" ;;
    *)                  fzf "$@" ;;
  esac
}

# load f into current shell in case cd is needed
alias f="source $DOTFILES/bin/f"

alias vf="fzf --bind 'enter:become(nvim {})' $FZF_CTRL_T_OPTS"

# }}}
# python {{{

alias pip="pip3"
alias makevenv="python3 -m venv .venv"
alias activate="source .venv/bin/activate"

export POETRY_VIRTUALENVS_IN_PROJECT=true
export POETRY_HOME=$HOME/.poetry

if test -d $POETRY_HOME; then
  export PATH="$POETRY_HOME/bin:$PATH"
fi

# set up pyenv
export PYENV_ROOT="$HOME/.pyenv"

if test -d "$PYENV_ROOT/bin"; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

if test $(command -v pyenv); then
  eval "$(pyenv init -)"
fi

# }}}
# ls {{{

eval $(dircolors $DOTFILES/zsh/LS_COLORS)
alias ls="ls --color=auto -Fh"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"

# }}}
# git {{{

alias ga="git add -A"
alias gac="git add -A && git commit -m"
alias gbd="git branch -d"
alias gc="git commit -m"
alias gco="git checkout"
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

# }}}
# npm {{{

if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_COLORS=Bmgre
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# }}}
# functions {{{

function mkcd() {
  mkdir -p "$1" && cd "$1";
}

# }}}
# prompt {{{
function collapse_pwd() {
  echo "%(5~|%-1~/.../%3~|%4~)"
}

PROMPT="%B%F{magenta}$(collapse_pwd)%f%b %# "

# shows branch name on right if applicable
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
git_color() {
  local git_status="$(git status 2> /dev/null)"
  local output_styles=""

  if [[ $git_status =~ "nothing to commit, working tree clean" ]]; then
    output_styles="green"
  elif [[ $git_status =~ "nothing added to commit but untracked files present" ]]; then
    output_styles="red"
  elif [[ $git_status =~ "no changes added to commit" ]]; then
    output_styles="red"
  elif [[ $git_status =~ "Changes to be committed" ]]; then
    output_styles="cyan"
  else
    output_styles="white"
  fi
  output_styles="%F{$output_styles}$1%f"

  echo "$output_styles"
}
RPROMPT='$(git_color ${vcs_info_msg_0_})'
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

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
fpath+="$HOME"/.zfunc

if test $(command -v brew); then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip3
# pip zsh completion end
# }}}

# add my own executables to $PATH
export PATH="$DOTFILES/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# remove uniques from $PATH and $FPATH
typeset -aU path
typeset -aU fpath

# setup fzf
if [ -f "$HOME"/.fzf.zsh ]; then
  source "$HOME"/.fzf.zsh
elif test $(command -v fzf) && $(command -v brew); then
  $(brew --prefix)/opt/fzf/install
fi

# setup z
export _ZO_DATA_DIR="${HOME}/.local/share/zoxide"
if [[ -a $_ZO_DATA_DIR ]]; then
  eval "$(zoxide init zsh)"
fi

# setup syntax highlighting and autosuggestions
if [[ $OSTYPE =~ ^darwin ]]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ $OSTYPE =~ ^linux ]]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi


# vi-mode
bindkey -v

# ctrl-space accepts autosuggestion
bindkey '^y' autosuggest-accept

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

bindkey -s '^v' 'vf\n'
bindkey -s '^f' 'tmux-sessionizer\n'
bindkey -s '^[t' 'tmux a\n'
