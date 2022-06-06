#!/usr/bin/env zsh

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

echo "Symlinking vim colors..."
# add custom colorscheme
rm -rf $HOME/.vim/colors
mkdir $HOME/.vim/colors
ln -s $DOTFILES/mycolors.vim $HOME/.vim/colors/mycolors.vim

echo "Symlinking .vimrc..."
rm -rf $HOME/.vimrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc
