#!/usr/bin/env bash

export DOTFILES=$HOME/.dotfiles

# install mac-specific things
if [[ $OSTYPE == darwin* ]]; then
  echo "Starting mac setup..."

  echo "Installing Xcode command line tools..."
  xcode-select --install

  source $DOTFILES/brew.sh

  source $DOTFILES/npm.sh
fi

# install linux-specific things
if [[ $OSTYPE == linux* ]]; then
  echo "Starting linux setup..."

  source $DOTFILES/apt.sh

  echo "Switching shell to zsh..."
  chsh -s $(which zsh)
fi

source $DOTFILES/vim.sh

source $DOTFILES/symlink.sh

source $DOTFILES/ssh.sh

# reload zsh config
source $HOME/.zshrc


if [[ $OSTYPE == darwin* ]]; then
  # Set macOS preferences - we will run this last because this will reload the shell
  source $DOTFILES/.macos
fi
