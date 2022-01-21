#!/bin/sh

echo "Setting up your Mac..."

echo "Installing homebrew..."
# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew recipes
brew update

echo "Installing packages..."
# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

echo "Setting up mac preferences..."
# Set macOS preferences - we will run this last because this will reload the shell
source .macos
