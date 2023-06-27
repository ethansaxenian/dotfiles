#!/usr/bin/env bash

echo "Generating a new SSH keypair..."

ssh-keygen -t ed25519 -C "ethan_saxenian"

eval "$(ssh-agent -s)"

cp $DOTFILES/ssh/config $HOME/.ssh/config

ssh-add --apple-use-keychain ~/.ssh/id_ed25519
