export EDITOR="vim"

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

if [[ $OSTYPE =~ ^darwin ]]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
    BAT=bat
elif [[ $OSTYPE =~ ^linux ]]; then
    BAT=batcat
fi

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

    alias vscode='open "/Applications/Visual Studio Code.app"'
    alias charm='open -a "PyCharm.app"'
    alias chrome='open "/Applications/Google Chrome.app"'
    alias word='open "/Applications/Microsoft Word.app"'
    alias spotify='open "/Applications/Spotify.app"'
    alias github='open "/Applications/GitHub Desktop.app"'
    alias facetime='open "/System/Applications/FaceTime.app"'
    alias messages='open "/System/Applications/Messages.app"'
    alias colorpicker='open "/System/Applications/Utilities/Digital Color Meter.app"'
    alias zoom='open "/Applications/zoom.us.app"'
    alias bitwarden='open "/Applications/Bitwarden.app"'
    alias utm='open "/Applications/UTM.app"'

    alias brewup="brew update && brew upgrade && brew cleanup"
    alias npmup='npm -g cache verify && npm -g update && npm-check-updates -u && npm install'
    alias sysup='sudo softwareupdate -i -a'

    # change architecture
    alias intel="env /usr/bin/arch -x86_64 /bin/zsh"
    alias arm="env /usr/bin/arch -arm64 /bin/zsh"

    # start linux VM
    alias startvm='open "utm://start?name=Ubuntu"'
fi
# }}}
# linux aliases {{{
if [[ $OSTYPE =~ ^linux ]]; then
    alias halt="sudo halt -p"
    alias reboot="sudo reboot"

    alias aptu="sudo apt update && sudo apt upgrade"
    alias apti="sudo apt install"
    alias aptr="sudo apt remove"
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

alias grep="grep --color=auto"

# Make shell handle commands containing a leading $
alias "$"="$@"

# use different theme for bat
alias bat="$BAT --theme=Visual\ Studio\ Dark+"

# colored help pages
alias bathelp="$BAT --plain --language=help"

# }}}
# python {{{

if test $(command -v poetry); then
    export POETRY_VIRTUALENVS_IN_PROJECT=true
    export POETRY_HOME=$HOME/.poetry
    export PATH="$POETRY_HOME/bin:$PATH"
fi

alias py="python3"
alias pip="pip3"
alias makevenv="python3 -m venv .venv"
alias activate="source .venv/bin/activate"

# set up pyenv
if test $(command -v pyenv); then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
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
    git diff --name-only --relative --diff-filter=d | xargs $BAT --diff
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

# }}}
# misc functions {{{

function help() {
    "$@" --help 2>&1 | bathelp
}

function path() {
    echo $PATH | tr ':' '\n'
}

# Call from a local repo to open the repository on github/bitbucket in browser
# Modified version of https://github.com/zeke/ghwd
function repo() {
	# Figure out github repo base URL
	local base_url
	base_url=$(git config --get remote.origin.url)
	base_url=${base_url%\.git} # remove .git from end of string

	# Fix git@github.com: URLs
	base_url=${base_url//git@github\.com:/https:\/\/github\.com\/}

	# Fix git://github.com URLS
	base_url=${base_url//git:\/\/github\.com/https:\/\/github\.com\/}

	# Fix git@bitbucket.org: URLs
	base_url=${base_url//git@bitbucket.org:/https:\/\/bitbucket\.org\/}

	# Fix git@gitlab.com: URLs
	base_url=${base_url//git@gitlab\.com:/https:\/\/gitlab\.com\/}

	# Validate that this folder is a git folder
	if ! git branch 2>/dev/null 1>&2 ; then
		echo "Not a git repo!"
		return $?
	fi

	# Find current directory relative to .git parent
	full_path=$(pwd)
	git_base_path=$(cd "./$(git rev-parse --show-cdup)" || exit 1; pwd)
	relative_path=${full_path#$git_base_path} # remove leading git_base_path from working directory

	# If filename argument is present, append it
	if [ "$1" ]; then
		relative_path="$relative_path/$1"
	fi

	# Figure out current git branch
	# git_where=$(command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
	git_where=$(command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null

	# Remove cruft from branchname
	branch=${git_where#refs\/heads\/}
	branch=${branch#remotes\/origin\/}

	[[ $base_url == *bitbucket* ]] && tree="src" || tree="tree"
	url="$base_url/$tree/$branch$relative_path"


	echo "Calling $(type open) for $url"

	open "$url" &> /dev/null || (echo "Using $(type open) to open URL failed." && exit 1);
}

# open a react native project in xcode
function xcode() {
    if [[ "$#" < 1 ]]; then
        open -a Xcode ios/
    else
        open -a Xcode $1/ios/
    fi
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


function battery_status() {
    if test "$(uname)" = "Darwin"
        then

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
    fi
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRN;
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

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# partial completion suggestions
zstyle ':completion:*' list-suffixeszstyle ':completion:*' expand prefix suffix
# }}}
# ssh {{{
# prompt displays more info if connected via ssh
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PROMPT="%B%F{red}%n@%m %~%f%b %# "
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

# remove uniques from $PATH
typeset -aU path

# colored manpages with bat
export MANPAGER="sh -c 'col -bx | $BAT --theme=Monokai\ Extended -l man -p'"


if [[ $OSTYPE =~ ^darwin ]]; then
    Z_PREFIX=$(brew --prefix)/etc/profile.d
    ZSH_SYNTAX_HIGHLIGHTING_PREFIX=$(brew --prefix)/share/zsh-syntax-highlighting
elif [[ $OSTYPE =~ ^linux ]]; then
    Z_PREFIX=$HOME/.local/z
    ZSH_SYNTAX_HIGHLIGHTING_PREFIX=$HOME/.local/zsh-syntax-highlighting
fi

source $Z_PREFIX/z.sh
source $ZSH_SYNTAX_HIGHLIGHTING_PREFIX/zsh-syntax-highlighting.zsh
