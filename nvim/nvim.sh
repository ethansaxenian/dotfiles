#!/usr/bin/env bash

echo "Setting up nvim directories..."
rm -rf "$HOME"/.config/nvim
ln -s "$DOTFILES"/nvim "$HOME"/.config/nvim
