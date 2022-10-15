#!/usr/bin/env bash

export DOTFILES=$HOME/.dotfiles

# install mac-specific things
if [[ $OSTYPE == ^darwin ]]; then
  echo "Starting mac setup..."

  echo "Installing Xcode command line tools..."
  xcode-select --install

  source $DOTFILES/scripts/brew.sh
fi

# install linux-specific things
if [[ $OSTYPE =~ ^linux ]]; then
  echo "Starting linux setup..."

  source $DOTFILES/scripts/apt.sh

  source $DOTFILES/scripts/ubuntu.sh
fi

source $DOTFILES/scripts/npm.sh

source $DOTFILES/scripts/python.sh

source $DOTFILES/scripts/vim.sh

source $DOTFILES/scripts/symlink.sh

source $DOTFILES/scripts/ssh.sh

$(brew --prefix)/opt/fzf/install

# reload zsh config
source $HOME/.zshrc

if [[ $OSTYPE =~ ^darwin ]]; then
  # Set macOS preferences - we will run this last because this will reload the shell
  source $DOTFILES/scripts/macos.sh
fi
