export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias myip="curl http://ipecho.net/plain; echo"
alias config="open ~/.zshrc"
alias ls="ls -G"
alias la="ls -a"

function acp(){
  git add .
  git commit -m "$1"
  git push
}

function irao(){
  git init
  git remote add origin "$1"
}

PROMPT='%B%F{red}%1~%f%b %# '

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