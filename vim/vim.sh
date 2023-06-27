#!/usr/bin/env bash

echo "Setting up .vim directories..."
ln -sf $DOTFILES/vim $HOME/.vim
mkdir $HOME/.vim/undo $HOME/.vim/swp

echo "Installing vim-plug and plugins..."
# install vim-plug and plugins
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall

python3 $HOME/.vim/plugged/youcompleteme/install.py --clangd-completer --go-completer --ts-completer
