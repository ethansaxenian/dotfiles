#!/usr/bin/env bash
echo "Symlinking bat config..."
rm -rf "$HOME"/.config/bat
ln -s "$DOTFILES"/.config/bat "$HOME"/.config/bat

echo "Symlinking fd ignore..."
rm -rf "$HOME"/.config/fd
ln -s "$DOTFILES"/.config/fd "$HOME"/.config/fd
