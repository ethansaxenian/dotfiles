#!/bin/sh

echo "Installing packages..."
sudo pacman --needed -S code firefox gcc gdb ghex git make man-db man-pages nasm openssh strace tree valgrind vim zsh wireshark-qt net-tools iputils gnu-netcat

chsh -s $(which zsh)

echo "Symlinking .gdbinit..."
rm -rf $HOME/.gdbinit
ln -s $HOME/.dotfiles/.gdbinit $HOME/.gdbinit
