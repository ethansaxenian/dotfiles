#!/usr/bin/env zsh

echo "Installing nvm, node, and npm packages..."

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
source $HOME/.nvm/nvm.sh

nvm install lts/fermium
nvm install stable
nvm use stable
nvm alias arm stable
nvm alias intel lts/fermium

if test $(which npm); then
  npm install --location=global spoof tldr
fi
