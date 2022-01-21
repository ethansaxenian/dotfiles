#!/bin/sh

echo "Setting up Arch Linux..."

echo "Installing packages..."
sudo pacman --needed -S code firefox gcc gdb ghex git make man-db man-pages nasm openssh strace tree valgrind vim zsh

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
mkdir $HOME/.vim/colors/ -p
ln -s $HOME/.dotfiles/vimcolors.vim $HOME/.vim/colors/custom.vim

echo "Symlinking .gdbinit..."
rm -rf $HOME/.gdbinit
ln -s $HOME/.dotfiles/.gdbinit $HOME/.gdbinit
