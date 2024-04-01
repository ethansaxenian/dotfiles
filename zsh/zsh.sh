#!/usr/bin/env bash

echo "Symlinking .zshrc..."
ln -sf "$DOTFILES"/zsh/.zshrc "$HOME"/.zshrc

echo "Symlinking .zprofile..."
ln -sf "$DOTFILES"/zsh/.zprofile "$HOME"/.zprofile

echo "Switching shell to zsh..."
chsh -s "$(which zsh)"

source "$HOME"/.zshrc
