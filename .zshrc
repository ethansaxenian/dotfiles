# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# displays ip address
alias myip="curl http://ipecho.net/plain; echo"

# opens the zsh config file for editing
alias config="vi ~/.dotfiles/.zshrc"

# reloads the terminal
alias reload="source ~/.zshrc"

# colors
alias ls="ls -FGh"
alias la="ls -A"
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

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

alias newbranch="git checkout -b"
alias gco="git checkout"
alias ga="git add ."
alias gc="git commit -m"
alias gac="git add . && git commit -m"
alias gpush="git push"
alias gpu="git push -u origin"
alias gs="git status"
alias gb="git branch"
alias gpull="git pull"

function acp(){
  git add .
  git commit -m "$1"
  git push
}

function initrepo(){
  git init
  git remote add origin "$1"
}

# saves this config file to github
function saveconfig() {
  cd
  cd .dotfiles
  acp "update .zshrc"
  cd
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
    time_left='⌛️ '
  fi

  if [[ $time_left == *"0:00"* ]]
  then
    time_left='⚡️ '
  fi

  printf "\033[1;92m$emoji  $time_left \033[0m"
}


PROMPT='$(battery_status)%B%F{red}%~%f%b %# '

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
# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
