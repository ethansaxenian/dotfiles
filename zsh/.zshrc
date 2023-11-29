# env variables {{{

export EDITOR="nvim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

if [[ $OSTYPE =~ ^darwin ]]; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
fi

if test -d "$HOME/.detaspace/bin"; then
  export PATH="$HOME/.detaspace/bin:$PATH"
fi

# colored manpages with bat
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=Monokai\ Extended'"

# }}}
# mac aliases {{{
if [[ $OSTYPE =~ ^darwin ]]; then
  # Empty the Trash on all mounted volumes and the main HDD.
  # Also, clear Apple’s System Logs to improve shell startup speed.
  # Finally, clear download history from quarantine. https://mths.be/bum
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

  alias charm='open -a "PyCharm.app"'

  alias sysup='sudo softwareupdate -i -a'

  alias brewup="brew update && brew upgrade && brew cleanup && brew autoremove"
fi
# }}}
# linux aliases {{{
if [[ "$OSTYPE" =~ ^linux ]]; then
  alias halt="sudo halt -p"
  alias reboot="sudo reboot"

  alias aptu="sudo apt update && sudo apt upgrade"
  alias apti="sudo apt install"
  alias aptr="sudo apt remove"
  alias aptar="sudo apt autoremove"
  alias aptl="apt list --installed"

  alias c="clear"
fi
# }}}
# misc aliases {{{

# enable aliases to be sudo'ed
alias sudo="sudo "

alias v="$EDITOR"
alias vim="$EDITOR"

# opens the zsh config file for editing
alias config="vim $DOTFILES/zsh/.zshrc"

alias vconfig="cd $DOTFILES/nvim && nvim init.lua"

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

export FZF_DEFAULT_OPTS='--height=100% --border --layout=default --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef --bind="alt-k:preview-up,alt-j:preview-down,ctrl-w:toggle-preview-wrap" --preview-window="border-left"'

export FD_EXCLUDES="{.Trash,node_modules,.git,.idea,__pycache__,Library,.venv,venv,ios,android,.android,.cocoapods}"
export FD_OPTIONS="--ignore --follow --strip-cwd-prefix -E '$FD_EXCLUDES'"
export FZF_DEFAULT_COMMAND="fd --type file $FD_OPTIONS"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_ALT_C_COMMAND="fd --type directory $FD_OPTIONS"
export FZF_ALT_C_OPTS="--preview 'tree -C {}' --bind 'ctrl-/:change-preview-window(hidden|)'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window up:3:hidden:wrap --bind 'ctrl-/:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"

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

bindkey -s '^v' 'fvim^M'

# load f into current shell in case cd is needed
alias f="source $DOTFILES/bin/f"

alias vf="fzf --bind 'enter:become(vim {})'"

# }}}
# python {{{

alias py="python3"
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
alias gb="git branch"
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

export NVM_COLORS=Bmgre
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias n="npm"
alias ni="npm install"
alias nid="npm install --save-dev"
alias nig="npm install --location=global"
alias nu="npm uninstall"
alias ns="npm start"
alias nfresh="rm -rf node_modules/ package-lock.json && npm install"
alias npmup='npm -g cache verify && npm -g update && npm-check-updates -u && npm install'

# }}}
# functions {{{

function mkcd() {
  mkdir -p "$1" && cd "$1";
}

# can do "up" or "up x"
function up {
  if [[ "$#" < 1 ]] ; then
    cd ..
  else
    CDSTR=""
    for i in {1..$1} ; do
      CDSTR="../$CDSTR"
    done
    cd $CDSTR
  fi
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
export HISTSIZE=2000

setopt NO_CASE_GLOB
setopt AUTO_CD
# share history across multiple zsh sessions
setopt SHARE_HISTORY
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
if test $(command -v bw); then
  eval "$(bw completion --shell zsh); compdef _bw bw;"
fi

fpath+="$HOME"/.zfunc

if test $(command -v brew); then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix

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
bindkey -v '^?' backward-delete-char

# tab-space accepts autosuggestion
bindkey '^ ' autosuggest-accept

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
