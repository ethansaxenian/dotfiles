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

echo "Symlinking .zshrc..."
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc-mac $HOME/.zshrc

echo "Symlinking .gitconfig..."
# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -rf $HOME/.gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

echo "Symlinking .vimrc..."
# Removes .vimrc from $HOME (if it exists) and symlinks the .vimrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc

echo "Installing vim-plug..."
# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Symlinking vim colorscheme..."
# add custom colorscheme
rm -rf $HOME/.vim/colors/custom.vim
rm -rf $HOME/.vim/colors/custom.vim
ln -s $HOME/.dotfiles/vimcolors.vim $HOME/.vim/colors/custom.vim

echo "Setting up mac preferences..."
# Set macOS preferences - we will run this last because this will reload the shell
source .macos
