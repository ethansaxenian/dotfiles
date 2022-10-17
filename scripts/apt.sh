#!/usr/bin/env bash

echo "Installing packages with apt..."
sudo apt update
sudo apt install -y bat fd-find firefox fzf gcc gdb git htop make neofetch net-tools nmap openssh-server spice-vdagent spice-webdavd terminator tree vim zoxide zsh

if test ! $(command -v bat); then
  sudo ln -s /usr/bin/batcat /usr/bin/bat
fi

if test ! $(command -v fdfind); then
  sudo ln -s /usr/bin/fdfind /usr/bin/fd
fi

if test ! $(command -v code); then
  echo "Installing vscode..."
  curl -L https://aka.ms/linux-arm64-deb --output code_arm64.deb
  sudo apt install -y ./code_arm64.deb
  rm code_arm64.deb
fi
