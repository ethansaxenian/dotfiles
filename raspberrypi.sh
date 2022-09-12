# configures a raspberry pi

# apt
sudo apt update
sudo apt install -y bat gcc gdb git htop make neofetch net-tools nmap openssh-server python3 python3-pip tree vim zsh

sudo ln -s /usr/bin/batcat /usr/bin/bat
# z
git clone https://github.com/rupa/z.git $HOME/.local/z
cp $HOME/.local/z/z.1 /usr/local/share/man/man1/ --parents

# zsh-syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.local/zsh-syntax-highlighting

# python
pip3 install tldr

# symlinks
rm -rf $HOME/.gitignore
ln -s $DOTFILES/.gitignore $HOME/.gitignore

rm -rf $HOME/.gitconfig
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig

rm -rf $HOME/.config/neofetch/config.conf
mkdir -p $HOME/.config/neofetch
ln -s $DOTFILES/neofetch.config $HOME/.config/neofetch/config.conf

# vim
source $DOTFILES/vim.sh

# ssh
source $DOTFILES/ssh.sh


# zsh
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc_pi $HOME/.zshrc

chsh -s $(which zsh)

source $HOME/.zshrc
