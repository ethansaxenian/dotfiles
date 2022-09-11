#!/usr/bin/env zsh

echo "Symlinking .zshrc..."
# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

echo "Symlinking .gitignore..."
rm -rf $HOME/.gitignore
ln -s $DOTFILES/.gitignore $HOME/.gitignore

echo "Symlinking .gitconfig..."
rm -rf $HOME/.gitconfig
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig

echo "Symlinking .tldrrc..."
rm -rf $HOME/.tldrrc
ln -s $DOTFILES/.tldrrc $HOME/.tldrrc

echo "Symlinking neofetch config..."
rm -rf $HOME/.config/neofetch/config.conf
mkdir -p $HOME/.config/neofetch
ln -s $DOTFILES/neofetch.config $HOME/.config/neofetch/config.conf

if [[ "$OSTYPE" =~ ^linux ]]; then
  echo "Configuring terminator..."
  rm -rf $HOME/.config/terminator/config
  mkdir -p $HOME/.config/terminator
  ln -s $DOTFILES/terminator.config $HOME/.config/terminator/config
fi
