#!/bin/sh

echo "Setting up Arch Linux..."

sudo pacman --needed -S code firefox gcc gdb ghex git make man-db man-pages nasm openssh strace tree valgrind vim zsh

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc-mac $HOME/.zshrc

# Removes .gitconfig from $HOME (if it exists) and symlinks the .gitconfig file from the .dotfiles
rm -rf $HOME/.gitconfig
ln -s $HOME/.dotfiles/.gitconfig $HOME/.gitconfig

# Removes .vimrc from $HOME (if it exists) and symlinks the .vimrc file from the .dotfiles
rm -rf $HOME/.vimrc
ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# add custom colorscheme
rm -rf $HOME/.vim/colors/custom.vim
ln -s $HOME/.dotfiles/vimcolors.vim $HOME/.vim/colors/custom.vim

rm -rf $HOME/.gdbinit
ln -s $HOME/.dotfiles/.gdbinit $HOME/.gdbinit
