#!/usr/bin/env bash

echo "Symlinking .gitconfig..."
ln -sf "$DOTFILES"/git/.gitconfig "$HOME"/.gitconfig

echo "Symlinking .gitignore..."
ln -sf "$DOTFILES"/git/.gitignore "$HOME"/.gitignore
