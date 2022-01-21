#!/bin/sh

# Path to your dotfiles.
export DOTFILES=$HOME/.dotfiles

if [[ "$OSTYPE" =~ ^darwin ]]; then
	$DOTFILES/configure-mac.sh
fi

if [[ "$OSTYPE" =~ ^linux ]]; then
	$DOTFILES/configure-arch.sh
fi

echo "Symlinking .zshrc..."
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

echo "Symlinking .gitconfig..."
# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -rf $HOME/.gitconfig
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig

echo "Symlinking .vimrc..."
# Removes .vimrc from $HOME (if it exists) and symlinks the .vimrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc

echo "Installing vim-plug..."
# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Symlinking vim colorschemes..."
# add custom colorscheme
rm -rf $HOME/.vim/colors/
mkdir $HOME/.vim/colors/ -p
ln -s $DOTFILES/vimcolors/* $HOME/.vim/colors
