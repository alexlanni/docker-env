#!/usr/bin/env bash

apt-get update

apt-get -y remove docker docker-engine docker.io containerd runc

apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io

usermod -aG docker vagrant

systemctl enable docker

apt-get install -y lynx

apt-get install -y zsh

## Install ZSH e oh-my-zsh

su vagrant -c "curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
su vagrant -c "sh install.sh --unattended"
#su vagrant -c "chsh -s $(which zsh)"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' /home/vagrant/.zshrc

echo "Please execute chsh -s $(which zsh) for switch to zsh."
