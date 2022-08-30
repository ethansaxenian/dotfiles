#!/usr/bin/env bash

echo "Installing packages with apt..."
sudo apt update
sudo apt install -y bat firefox gcc gdb git htop make spice-vdagent spice-webdavd terminator tree vim zsh

# pyenv environment - https://github.com/pyenv/pyenv/wiki#suggested-build-environment
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-devwh

pip3 install thefuck --user

# 'bat' is installed as 'batcat' so create a symlink to 'bat'
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo "Installing vscode..."
curl -L https://aka.ms/linux-arm64-deb --output code_arm64.deb
sudo apt install -y ./code_arm64.deb
rm code_arm64.deb

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
