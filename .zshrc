export EDITOR="vim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

if [[ "$OSTYPE" =~ ^darwin ]]; then
	source $HOME/.dotfiles/mac.zsh
fi

if [[ "$OSTYPE" =~ ^linux ]]; then
	source $HOME/.dotfiles/arch.zsh
fi

# enable aliases to be sudo'ed
alias sudo="sudo "

# rerun the previous command with sudo (lol)
alias ffs="sudo !!"

alias v="vim"

alias vconfig="v ~/.vimrc"

function mkcd() {
  mkdir "$1" && cd "$1";
}

# displays ip address
alias myip="curl http://ipecho.net/plain; echo"

# opens the zsh config file for editing
alias config="vim ~/.zshrc"

# reloads the terminal
alias reload="source ~/.zshrc"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

alias dotfiles="cd ~/.dotfiles"

alias la="ls -Ah"
alias ll="ls -lh"
alias lla="ls -lAh"

alias grep="grep --color=auto"
alias m="make"
alias mc="make clean"

alias path="echo $PATH | tr ':' '\n'"

alias ga="git add -A"
alias gac="git add -A && git commit -m"
alias gb="git branch"
alias gbd="git branch -d"
alias gc="git commit -m"
alias gco="git checkout"
alias gd="git diff --color | sed 's/^\([^-+ ]*\)[-+ ]/\\1/' | less -r"
alias gf="git fetch"
alias gl="git pull --prune"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias grst="git reset ."
alias gp="git push"
alias gpu="git push -u origin"
alias gs="git status -sb"
alias gst="git stash"
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
    du $arg .[^.]* ./*;
  fi;
}

function weather() {
  city="$1"

  if [ -z "$city" ]; then
    city="Middlebury"
  fi

  eval "curl http://wttr.in/${city}"
}

# display a list of supported colors
function lscolors {
	((cols = $COLUMNS - 4))
	s=$(printf %${cols}s)
	for i in {000..$(tput colors)}; do
		echo -e $i $(tput setaf $i; tput setab $i)${s// /=}$(tput op);
	done
}

# colorized manpages
function man() {
	env \
		LESS_TERMCAP_md=$'\e[1;36m' \
		LESS_TERMCAP_me=$'\e[0m' \
		LESS_TERMCAP_se=$'\e[0m' \
		LESS_TERMCAP_so=$'\e[1;40;92m' \
		LESS_TERMCAP_ue=$'\e[0m' \
		LESS_TERMCAP_us=$'\e[1;32m' \
			man "$@"
}

function battery_status() {
  if test ! "$(uname)" = "Darwin"
    then
    printf ""
    exit 0
  fi

  battstat=$(pmset -g batt)
  time_left=$(echo $battstat |
    tail -1 |
    cut -f2 |
    awk -F"; " '{print $3}' |
    cut -d' ' -f1
  )

  if [[ $(pmset -g ac) == *"No adapter attached."* ]]
  then
    emoji='🔋'
  else
    emoji='🔌'
  fi

  if [[ $time_left == *"(no"* || $time_left == *"not"* ]]
  then
    time_left='⌛️'
  fi

  if [[ $time_left == *"0:00"* ]]
  then
    time_left='⚡️'
  fi

  printf "\033[1;92m$emoji  $time_left\n\033[0m"
}

PROMPT='%B%F{red}%.%f%b %# '

# shows branch name on right if applicable
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f'
zstyle ':vcs_info:*' enable git

setopt NO_CASE_GLOB
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt CORRECT
setopt CORRECT_ALL

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
