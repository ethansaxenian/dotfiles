#!/usr/bin/env zsh

echo "Setting up vim configuration..."
echo "Installing vim-plug and plugins..."
# install vim-plug and plugins
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

echo "Setting up .vim directories..."
rm -rf $HOME/.vim/undo $HOME/.vim/swp
mkdir $HOME/.vim/undo $HOME/.vim/swp

