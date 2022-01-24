#!/bin/sh

echo "Setting up Arch Linux..."

echo "Installing packages..."
sudo pacman --needed -S code firefox gcc gdb ghex git make man-db man-pages nasm openssh strace tree valgrind vim zsh wireshark-qt net-tools iputils

echo "Symlinking .gdbinit..."
rm -rf $HOME/.gdbinit
ln -s $HOME/.dotfiles/.gdbinit $HOME/.gdbinit
