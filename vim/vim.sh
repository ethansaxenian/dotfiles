#!/usr/bin/env bash

echo "Setting up .vim directories..."
rm -rf "$HOME"/.vim/
ln -s "$DOTFILES"/vim "$HOME"/.vim
mkdir "$HOME"/.vim/undo "$HOME"/.vim/swp
ln -sf "$DOTFILES"/vim/.ideavimrc "$HOME"/.ideavimrc

echo "Installing vim-plug and plugins..."
# install vim-plug and plugins
curl -fLo "$HOME"/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
vim +CocInstall coc-clangd coc-json coc-sh coc-gopls coc-pyright
