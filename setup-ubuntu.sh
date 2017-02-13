#!/bin/sh

git clone https://github.com/rawaludin/dotfiles.git
ln -sf dotfiles/.bashrc .
ln -sf dotfiles/.gitconfig .
ln -sf dotfiles/.inputrc .
ln -sf dotfiles/.tmux.conf .
ln -sf dotfiles/.config .

# directory structure
mkdir ~/code

# neovim
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim python3-dev python3-pip
sudo pip3 install --upgrade neovim
nvim +PlugInstall +qall

# php
sudo apt-get install -y php php-mbstring php-xml php-zip curl php-cli git php-curl
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# mysql
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server
mysql -u root -proot -e "CREATE USER 'homestead'@'localhost' IDENTIFIED BY 'secret'"
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'localhost';"
mysql -u homestead -psecret -e "create database homestead;"


