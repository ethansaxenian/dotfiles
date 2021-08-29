export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# displays ip address
alias myip="curl http://ipecho.net/plain; echo"

# opens the zsh config file
alias config="vi ~/zshconfig/.zshrc"

# reloads the terminal
alias reload="source ~/.zshrc"

# colors directory names blue
alias ls="ls -GF"
alias la="ls -aGF"

alias activate="source venv/bin/activate"

function acp(){
  git add .
  git commit -m "$1"
  git push
}

function irao(){
  git init
  git remote add origin "$1"
}

# saves this config file to github
function saveconfig() {
  cd
  cd zshconfig
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

PROMPT='%B%F{red}%1~%f%b %# '

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
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' # partial completion suggestions zstyle ':completion:*' list-suffixes zstyle ':completion:*' expand prefix suffix

osascript -e 'tell application "System Preferences" to quit'

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Disable the annoying line marks in terminal
defaults write com.apple.Terminal ShowLineMarks -int 0

# Disable automatic emoji substitution (i.e. use plain text smileys)
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
