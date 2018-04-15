#!/bin/sh

# copy ssh public key
# ssh-copy-id -i ~/.ssh/mykey user@host

git clone https://github.com/rawaludin/dotfiles.git
ln -sf dotfiles/.bashrc .
source ~/.bashrc
ln -sf dotfiles/.gitconfig .
ln -sf dotfiles/.inputrc .
ln -sf dotfiles/.editrc .
ln -sf dotfiles/.tmux.conf .
ln -sf dotfiles/.config .

# directory structure
mkdir ~/code

# php
sudo apt-get install -y php php-mbstring php-xml php-zip curl php-cli git php-curl php-mysql php-xdebug
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

# neovim
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim python3-dev python3-pip
sudo pip3 install --upgrade neovim
nvim +PlugInstall +qall

# docker
sudo apt-get remove docker docker-engine docker.io
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# gcloud
# Create an environment variable for the correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install -y google-cloud-sdk

# kubernetes client (kubectl)
export KUBERNETES_REPO="kubernetes-$(lsb_release -c -s)"
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ $KUBERNETES_REPO main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.26.0/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/


# important utility
sudo apt-get install silversearcher-ag
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep_0.8.1_amd64.deb
sudo dpkg -i ripgrep_0.8.1_amd64.deb

# example: open port
# sudo ufw allow 8080/tcp

# mysql
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
# sudo apt-get install -y mysql-server
# mysql -u root -proot -e "CREATE USER 'homestead'@'localhost' IDENTIFIED BY 'secret'"
# mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'homestead'@'localhost';"
# mysql -u homestead -psecret -e "create database homestead;"

# timezone
sudo timedatectl set-timezone Asia/Jakarta

# turnoff default apache2
sudo service apache2 stop
sudo apt-get remove -y apache2
sudo apt-get autoremove -y

# zsh
# sudo apt-get install -y zsh
# sudo chsh -s `which zsh` $USER
# curl -sL zplug.sh/installer | zsh
