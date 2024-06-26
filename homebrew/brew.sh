#!/usr/bin/env bash

# Check for Homebrew and install if we don't have it
if test ! "$(command -v brew)"; then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

echo "Installing packages with homebrew..."
# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file "$DOTFILES"/homebrew/Brewfile

"$(brew --prefix)"/opt/fzf/install
