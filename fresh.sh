#!/bin/bash

export DOTFILES=$HOME/.dotfiles

if [[ $OSTYPE == darwin* ]]; then
  echo "Installing Xcode command line tools..."
  xcode-select --install
fi

# install mac-specific things
if [[ $OSTYPE == darwin* ]]; then
  echo "Starting mac setup..."
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
fi

# install linux-specific things
if [[ $OSTYPE == linux* ]]; then
  echo "Starting linux setup..."
  sudo apt update
  sudo apt install -y firefox gcc gdb git htop make python3 python3-dev python3-pip python3-setuptools tldr tree vim zsh

  echo "Installing vscode..."
  curl -L https://aka.ms/linux-arm64-deb > code_arm64.deb
  sudo apt install -y ./code_arm64.deb
  rm code_arm64.deb

  echo "Switching shell to zsh..."
  chsh -s $(which zsh)
fi

echo "Symlinking .zshrc..."
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

echo "Symlinking .gitignore..."
rm -rf $HOME/.gitignore
ln -s $DOTFILES/.gitignore $HOME/.gitignore

echo "Symlinking .gitconfig..."
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
rm -rf $HOME/.vimrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc

echo "Symlinking .gdbinit..."
rm -rf $HOME/.gdbinit
ln -s $HOME/.dotfiles/.gdbinit $HOME/.gdbinit


source $DOTFILES/.zshrc


if [[ $OSTYPE == darwin* ]]; then
  echo "Setting up mac preferences..."
  # Set macOS preferences - we will run this last because this will reload the shell
  source $DOTFILES/.macos
fi
