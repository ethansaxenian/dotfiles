#!/bin/zsh

export DOTFILES="$HOME/.dotfiles"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update
brew bundle --file "$DOTFILES/Brewfile"
"$(brew --prefix)/opt/fzf/install"

ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"

chsh -s "$(which zsh)"
source "$DOTFILES/.zshrc"

ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES/.gitignore" "$HOME/.gitignore"
ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$DOTFILES/.config/bat" "$XDG_CONFIG_HOME/bat"
ln -sf "$DOTFILES/.config/fd" "$XDG_CONFIG_HOME/fd"
ln -sf "$DOTFILES/.config/ghostty" "$XDG_CONFIG_HOME/ghostty"

uv python install --default
