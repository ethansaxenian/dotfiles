# configures a raspberry pi

# apt
sudo apt update
sudo apt install -y bat fd-find fzf gcc gdb git htop make neofetch net-tools nmap openssh-server python3 python3-pip tree vim zoxide zsh

sudo ln -s /usr/bin/batcat /usr/bin/bat
sudo ln -s /usr/bin/fdfind /usr/bin/fd

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

rm -rf $HOME/.config/bat/config
mkdir -p $HOME/.config/bat
ln -s $DOTFILES/bat.config $HOME/.config/bat/config

# vim
source $DOTFILES/scripts/vim.sh

# ssh
source $DOTFILES/scripts/ssh.sh


# zsh
rm -rf $HOME/.zshrc
ln -s $DOTFILES/.zshrc_pi $HOME/.zshrc

chsh -s $(which zsh)

source $HOME/.zshrc
