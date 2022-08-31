echo "Switching shell to zsh..."
chsh -s $(which zsh)

echo "Syncing dotfiles repo..."
cd $DOTFILES
git init .
git remote add origin git@github.com:ethansaxenian/dotfiles.git
git pull

echo "Configuring terminator..."
rm -rf $HOME/.config/terminator/config
mkdir -p $HOME/.config/terminator
ln -s $DOTFILES/terminator_config $HOME/.config/terminator/config

echo "Installing z..."
git clone git@github.com:rupa/z.git $LOCAL/z

echo "Installing zsh-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $LOCAL/zsh-syntax-highlighting
