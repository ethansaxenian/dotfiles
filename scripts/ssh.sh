#!/usr/bin/env zsh

echo "Generating a new SSH keypair..."

ssh-keygen -t ed25519 -C "ethansaxenian@proton.me"

eval "$(ssh-agent -s)"

if [[ $OSTYPE == ^darwin ]]; then
  touch ~/.ssh/config
  echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519
fi

if [[ $OSTYPE =~ ^linux ]]; then
  ssh-add ~/.ssh/id_ed25519
fi

cat ~/.ssh/id_ed25519.pub
echo "copy that ^ and paste into GitHub"
