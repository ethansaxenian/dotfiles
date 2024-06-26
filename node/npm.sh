#!/usr/bin/env bash

echo "Installing nvm, node, and npm packages..."

if test ! "$(command -v nvm)"; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
  source "$HOME"/.nvm/nvm.sh
fi

nvm install stable
nvm use stable
