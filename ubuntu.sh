echo "Switching shell to zsh..."
chsh -s $(which zsh)

echo "Syncing dotfiles repo..."
cd $HOME
rm -rf $DOTFILES
git clone https://github.com/ethansaxenian/dotfiles.git $DOTFILES

echo "Installing z..."
git clone https://github.com/rupa/z.git $HOME/.local/z
cp $HOME/.local/z/z.1 /usr/local/share/man/man1/ --parents

echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/zsh-syntax-highlighting
