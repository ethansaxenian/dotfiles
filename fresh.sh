#!/bin/sh

export DOTFILES=$HOME/.dotfiles

echo "Switching shell to zsh..."
# use zsh
chsh -s $(which zsh)

echo "Installing Xcode command line tools..."
xcode-select --install

echo "Symlinking .zshrc..."
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

echo "Symlinking .gitignore..."
# Removes .gitignore from $HOME (if it exists) and symlinks the .gitignore file from the .dotfiles
rm -rf $HOME/.gitignore
ln -s $DOTFILES/.gitignore $HOME/.gitignore

echo "Symlinking .gitconfig..."
# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -rf $HOME/.gitconfig
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig

echo "Setting up vim configuration..."
echo "Installing vim-plug and plugins..."
# install vim-plug and plugins
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

echo "Setting up .vim directories..."
rm -rf $HOME/.vim/undo $HOME/.vim/swp
mkdir $HOME/.vim/undo $HOME/.vim/swp

echo "Symlinking vim colors..."
# add custom colorscheme
rm -rf $HOME/.vim/colors
mkdir $HOME/.vim/colors
ln -s $DOTFILES/mycolors.vim $HOME/.vim/colors/mycolors.vim

echo "Symlinking .vimrc..."
# Removes .vimrc from $HOME (if it exists) and symlinks the .vimrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc

echo "Installing homebrew..."
# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Update Homebrew recipes
brew update

echo "Installing packages with homebrew..."
# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $DOTFILES/Brewfile

echo "Installing npm packages..."
source $DOTFILES/.npm

echo "Setting up mac preferences..."
# Set macOS preferences - we will run this last because this will reload the shell
source $DOTFILES/.macos
