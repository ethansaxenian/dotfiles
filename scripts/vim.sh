#!/usr/bin/env zsh


# echo "Symlinking vim colors..."
# # add custom colorscheme
# rm -rf $HOME/.vim/colors
# mkdir -p $HOME/.vim/colors
# ln -s $DOTFILES/mycolors.vim $HOME/.vim/colors/mycolors.vim

# echo "Symlinking .vimrc..."
# rm -rf $HOME/.vimrc
# ln -s $DOTFILES/.vimrc $HOME/.vimrc

echo "Setting up .vim directories..."
rm -rf $HOME/.vim
ln -s $DOTFILES/.vim $HOME/.vim
mkdir $HOME/.vim/undo $HOME/.vim/swp

echo "Installing vim-plug and plugins..."
# install vim-plug and plugins
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
