#!/usr/bin/env bash

echo "Symlinking .tmux.conf..."
ln -sf $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
