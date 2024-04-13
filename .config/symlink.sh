#!/usr/bin/env bash
echo "Symlinking .tldrrc..."
ln -sf "$DOTFILES"/.config/.tldrrc "$HOME"/.tldrrc

echo "Symlinking neofetch config..."
rm -rf "$HOME"/.config/neofetch
ln -s "$DOTFILES"/.config/neofetch "$HOME"/.config/neofetch

echo "Symlinking bat config..."
rm -rf "$HOME"/.config/bat
ln -s "$DOTFILES"/.config/bat "$HOME"/.config/bat

echo "Symlinking fd ignore..."
rm -rf "$HOME"/.config/fd
ln -s "$DOTFILES"/.config/fd "$HOME"/.config/fd
