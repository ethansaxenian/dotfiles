export EDITOR="vim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


alias checksize="du -sh ~/* | sort -hr && du -sh ~/.* | sort -hr"

# Personal
alias coding="cd ~/Documents/Programming/"

alias startvm="VBoxManage startvm EthanLinux"

# colors
eval `gdircolors ~/.dotfiles/LS_COLORS`
alias ls="gls --color -Fh"

alias py="python3"
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

alias n="npm"
alias ni="npm install"
alias nd="npm install --save-dev"
alias nu="npm uninstall"

alias sva="svn add"
alias svc="svn commit -m"
alias svs="svn status"
alias svu="svn update"

alias brewup="brew update && brew upgrade && brew cleanup"
alias npmup='npm -g cache verify && npm -g update && npm-check-updates -u && npm install'
alias sysup='sudo softwareupdate -i -a'

# remove uniques from $PATH
typeset -aU path
