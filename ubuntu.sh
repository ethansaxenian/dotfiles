echo "Switching shell to zsh..."
chsh -s $(which zsh)

echo "Syncing dotfiles repo..."
cd $HOME
rm -rf $DOTFILES
git clone https://github.com/ethansaxenian/dotfiles.git $DOTFILES

echo "Configuring terminator..."
rm -rf $HOME/.config/terminator/config
mkdir -p $HOME/.config/terminator
ln -s $DOTFILES/terminator_config $HOME/.config/terminator/config

echo "Installing z..."
git clone https://github.com/rupa/z.git $HOME/.local/z

echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/zsh-syntax-highlighting
