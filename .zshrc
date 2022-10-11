# env variables {{{

export EDITOR="vim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

if [[ $OSTYPE =~ ^darwin ]]; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
fi

if test -d "$HOME/.deta/bin"; then
  export PATH="$HOME/.deta/bin:$PATH"
fi

# colored manpages with bat
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=Monokai\ Extended'"

# }}}
# mac aliases {{{
if [[ $OSTYPE =~ ^darwin ]]; then
  # Recursively delete `.DS_Store` files
  alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

  # Empty the Trash on all mounted volumes and the main HDD.
  # Also, clear Apple’s System Logs to improve shell startup speed.
  # Finally, clear download history from quarantine. https://mths.be/bum
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

  # Show/hide hidden files in Finder
  alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

  alias charm='open -a "PyCharm.app"'
  alias colorpicker='open "/System/Applications/Utilities/Digital Color Meter.app"'

  alias sysup='sudo softwareupdate -i -a'

  # change architecture
  alias intel="env /usr/bin/arch -x86_64 /bin/zsh"
  alias arm="env /usr/bin/arch -arm64 /bin/zsh"

  # start ubuntu VM
  alias startvm='open "utm://start?name=Ubuntu"'

  # homebrew
  alias brews="brew search"
  alias brewi="brew install"
  alias brewr="brew uninstall"
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

alias v="vim"

# displays ip address
alias myip="curl http://ipecho.net/plain; echo"

# opens the zsh config file for editing
alias config="vim $DOTFILES/.zshrc"

alias vconfig="vim $DOTFILES/.vimrc"

# reloads the terminal
alias reload="source $HOME/.zshrc"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

alias checksize="du -sch $HOME/* $HOME/.* | sort -hr"

alias grep="grep --color=auto -E"

# Make shell handle commands containing a leading $
alias "$"="$@"

# colored help pages
alias bathelp="bat --plain --language=help"

# disable autocorrect for certain commands
no_autocorrect=('cp' 'mv')
for c in $no_autocorrect; do
  alias "$c"="nocorrect $c"
done

# }}}
# fzf {{{

export FZF_DEFAULT_OPTS='--reverse --border --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'

RG_IGNORES="!{node_modules,.git,.idea,__pycache__,Library,.venv,ios,android,.android,.cocoapods}"
export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '$RG_IGNORES'"
export FZF_CTRL_T_COMMAND="rg --files -g '$RG_IGNORES' --sort path --null | xargs -0 dirname | uniq"

# Use rg instead of the default find command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  rg --files --follow --no-ignore-vcs --hidden -g "$RG_IGNORES"
}

# Use rg to generate the list for directory completion
_fzf_compgen_dir() {
  rg --files -g "$RG_IGNORES" --hidden --null | xargs -0 dirname | sort -u
}

function f() {
  cmd="$1"

  # if no arguments provided, just do fzf
  if [[ -z "$cmd" ]]; then
    fzf
  else
    # specify commands to search directories
    if [[ "$cmd" =~ "cd|code|charm" ]]; then
      dir=$(rg "$HOME" --files -g "$RG_IGNORES" --hidden --null | xargs -0 dirname | sort -u | fzf --preview "tree -C {}")

      if [[ -z "$dir" ]]; then
        return 1
      fi

      if [[ "$cmd" == "charm" ]]; then
        open -a "PyCharm.app" "$dir"
      else
        "$cmd" "$dir"
      fi
    else
      # otherwise normal fzf with bat preview
      file=$(rg "$HOME" --files --follow --no-ignore-vcs --hidden -g "$RG_IGNORES" | fzf --preview "bat --style=numbers --color=always {}")

      if [[ -z "$file" ]]; then
        return 1
      fi

      "$cmd" "$file"
    fi
  fi
}

# fzf in $PATH
function fp() {
  tr ':' '\n' <<< "$PATH" | xargs -I % find -L % -type f 2>/dev/null | fzf
}

function fman() {
  # get all files in manpath
  manpath_files=$(manpath | tr ':' '\n' | xargs -I % find -L % -type f 2>/dev/null)
  # strip path prefixes
  file_names=$(echo "$manpath_files" | sed -E 's/\// /g' | awk 'NF{ print $NF }')
  # strip all file extensions that don't designate a man section
  mans=$(echo "$file_names" | sed -E 's/\.(3(cc|x|tcl|tiff|G|pcap(\.in)?)|[1n](tcl)?|1m|gz)$//' | sort -u)
  # use fzf to get the desired page
  page=$(echo "$mans" | fzf --exact)
  # extract the section
  section=$(echo "$page" | grep -oE "\.([1-9]|3pm)$" | sed 's/\.//')

  if test -n "$section"; then
    # use man with the correct section if necessary
    echo "$page" | sed -E 's/\.([1-9]|3pm)$//' | xargs man "$section"
  else
    man "$page"
  fi
}

# }}}
# python {{{

alias py="python3"
alias pip="pip3"
alias makevenv="python3 -m venv .venv"
alias activate="source .venv/bin/activate"

# poetry aliases
alias poei="poetry install"
alias poea="poetry add"
alias poer="poetry remove"
alias poes="poetry shell"

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

eval `dircolors $DOTFILES/LS_COLORS`
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
alias gd="git diff --color | sed 's/^\([^-+ ]*\)[-+ ]/\\1/' | less -rFX"
alias gf="git fetch"
alias gl="git pull --prune"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias grst="git reset ."
alias gp="git push"
alias gpu="git push -u origin"
alias gs="git status -sb"
alias gst="git stash -u"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"

function acp(){
  git add -A
  git commit -m "$1"
  git push
}

function gcob {
  git checkout -b "$1"
  git push -u origin "$1"
}

function ginit(){
  git init
  git remote add origin "$1"
  git add -A
  git commit -m "initial commit"
  git push -u origin main
}

# git diff with bat
function batdiff() {
  git diff --name-only --relative --diff-filter=d | xargs bat --diff --diff-context=4
}

# }}}
# npm {{{

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
# misc functions {{{

function help() {
  "$@" --help 2>&1 | bathelp
}

function path() {
  echo $PATH | tr ':' '\n'
}

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

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh;
  else
    local arg=-sh;
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@";
  else
    du $arg .[^.]* ./* | sort -hr
  fi;
}


# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules' --dirsfirst "$@" | less -FRN;
}

# }}}
# prompt {{{
PROMPT="%B%F{red}%.%f%b %# "

# shows branch name on right if applicable
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f'
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

fpath+=~/.zfunc

if test $(command -v brew); then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
# }}}
# ssh {{{
# prompt displays more info if connected via ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  PROMPT="%B%F{magenta}%n@%m%f%b %B%F{red}%~%f%b %# "
fi

# change iterm profile when using ssh
function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Ethan"; fi
  echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
  NAME="Ethan"
  echo -e "\033]50;SetProfile=$NAME\a"
}

function colorssh() {
  if [[ -n "$ITERM_SESSION_ID" ]]; then
    trap "tab-reset" INT EXIT
    tabc SSH
  fi
  ssh $*
}
compdef _ssh tabc=ssh

alias ssh="colorssh"
# }}}

# add my own executables to $PATH
export PATH="$DOTFILES/bin:$PATH"

# remove uniques from $PATH and $FPATH
typeset -aU path
typeset -aU fpath

if [[ $OSTYPE =~ ^darwin ]]; then
  ZSH_SYNTAX_HIGHLIGHTING_PREFIX=$(brew --prefix)/share/zsh-syntax-highlighting
elif [[ $OSTYPE =~ ^linux ]]; then
  ZSH_SYNTAX_HIGHLIGHTING_PREFIX=$HOME/.local/zsh-syntax-highlighting
fi

source $ZSH_SYNTAX_HIGHLIGHTING_PREFIX/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"
