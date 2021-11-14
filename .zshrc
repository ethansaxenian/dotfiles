export EDITOR="vim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Enable aliases to be sudo’ed
alias sudo='sudo '

# rerun the previous command with sudo (lol)
alias ffs="sudo !!"

alias checksize="du -sh ~/* | sort -hr && du -sh ~/.* | sort -hr"

# Personal
alias coding="cd ~/Documents/Programming"

alias startvm="VBoxManage startvm CS315"

# displays ip address
alias myip="curl http://ipecho.net/plain; echo"

# opens the zsh config file for editing
alias config="v ~/.dotfiles/.zshrc"

# reloads the terminal
alias reload="source ~/.zshrc"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

alias dotfiles="cd ~/.dotfiles"

# colors
eval `gdircolors ~/.dotfiles/LS_COLORS`
alias ls="gls --color -Fh"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"

alias v="vim"

alias activate="source venv/bin/activate"

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

alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

alias vscode='open "/Applications/Visual Studio Code.app"'
alias pycharm='open "/Applications/PyCharm CE.app"'
alias chrome='open "/Applications/Google Chrome.app"'
alias word='open "/Applications/Microsoft Word.app"'
alias spotify='open "/Applications/Spotify.app"'
alias github='open "/Applications/GitHub Desktop.app"'
alias facetime='open "/System/Applications/FaceTime.app"'
alias messages='open "/System/Applications/Messages.app"'
alias colorpicker='open "/System/Applications/Utilities/Digital Color Meter.app"'
alias blender='open "/Applications/Blender.app"'

alias grep="grep --color=auto"
alias m="make"
alias mc="make clean"

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
alias gstp="git stash pop"

function gcob {
  git checkout -b "$1"
  git push -u origin "$1"
}

alias n="npm"
alias ni="npm install"
alias nd="npm install --save-dev"

alias sva="svn add"
alias svc="svn commit -m"
alias svs="svn status"
alias svu="svn update"

# Print each PATH entry on a separate line
alias path='echo $PATH | tr ":" "\n"'

alias brewup='brew update && brew upgrade && brew cleanup'
alias npmup='npm -g cache verify && npm -g update && npm-check-updates -u && npm install'
alias sysup='sudo softwareupdate -i -a'


function acp(){
  git add -A
  git commit -m "$1"
  git push
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

function mkcd {
	mkdir -p $1
	cd $1
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

function apod {
  dateparam="?date=${1}"

  if [ -z "$1" ]; then
    dateparam=""
  fi

  open $(curl -s "https://apodapi.herokuapp.com/api/${dateparam}" | python3 -c "import sys, json; print(json.load(sys.stdin)['apod_site'])")
}

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



# remove uniques from $PATH
typeset -aU path
