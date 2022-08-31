#!/usr/bin/env bash

echo "Installing packages with apt..."
sudo apt update
sudo apt install -y bat firefox gcc gdb git htop make spice-vdagent spice-webdavd terminator tree vim zsh

echo "Installing vscode..."
curl -L https://aka.ms/linux-arm64-deb --output code_arm64.deb
sudo apt install -y ./code_arm64.deb
rm code_arm64.deb
