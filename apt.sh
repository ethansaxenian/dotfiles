#!/usr/bin/env bash

echo "Installing packages with apt..."
sudo apt update
sudo apt install -y firefox gcc gdb git htop make python3 python3-dev python3-pip python3-setuptools terminator tree vim zsh

pip3 install thefuck --user

echo "Installing vscode..."
curl -L https://aka.ms/linux-arm64-deb --output code_arm64.deb
sudo apt install -y ./code_arm64.deb
rm code_arm64.deb
