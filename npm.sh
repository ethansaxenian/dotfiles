#!/usr/bin/env zsh

echo "Installing nvm, node, and npm packages..."

if test ! $(command -v nvm); then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
    source $HOME/.nvm/nvm.sh
fi

nvm install stable
nvm use stable

# use a bold blue for colors
nvm set-colors Bmgre

if test $(command -v npm); then
  npm install --location=global @bitwarden/cli tldr
fi
