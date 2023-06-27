#!/usr/bin/env bash
echo "Symlinking .tldrrc..."
ln -sf $DOTFILES/config/.tldrrc $HOME/.tldrrc

echo "Symlinking neofetch config..."
mkdir -p $HOME/.config/neofetch
ln -sf $DOTFILES/config/neofetch.config $HOME/.config/neofetch/config.conf

echo "Symlinking bat config..."
mkdir -p $HOME/.config/bat
ln -sf $DOTFILES/config/bat.config $HOME/.config/bat/config
