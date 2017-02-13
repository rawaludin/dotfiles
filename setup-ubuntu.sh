#!/bin/sh

git clone https://github.com/rawaludin/dotfiles.git
ln -sf dotfiles/.bashrc .
ln -sf dotfiles/.gitconfig .
ln -sf dotfiles/.inputrc .
ln -sf dotfiles/.tmux.conf .
ln -sf dotfiles/.config .

# neovim
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim python3-dev python3-pip
sudo pip3 install --upgrade neovim
nvim +PlugInstall +qall

