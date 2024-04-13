#!/usr/bin/env bash

export DOTFILES=$HOME/.dotfiles

echo "Installing Xcode command line tools..."
xcode-select --install

source "$DOTFILES"/homebrew/brew.sh

source "$DOTFILES"/python/python.sh

source "$DOTFILES"/node/npm.sh

source "$DOTFILES"/vim/vim.sh

source "$DOTFILES"/.config/symlink.sh

source "$DOTFILES"/git/git.sh

source "$DOTFILES"/zsh/zsh.sh

# Set macOS preferences - we will run this last because this will reload the shell
source "$DOTFILES"/macos/macos.sh
