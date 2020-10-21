#!/usr/bin/env bash

apt-get update

apt-get -y remove docker docker-engine docker.io containerd runc

apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io

usermod -aG docker vagrant

## Abilitazione API Docker
sed -i 's+-H fd://+-H fd:// -H=tcp://0.0.0.0:2375+g' /lib/systemd/system/docker.service

systemctl enable docker

systemctl daemon-reload

service docker restart

apt-get install -y docker-compose gnupg2 pass lynx zsh unzip

## Install ZSH e oh-my-zsh

su vagrant -c "curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
su vagrant -c "sh install.sh --unattended"
#su vagrant -c "chsh -s $(which zsh)"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' /home/vagrant/.zshrc

chsh -s $(which zsh) vagrant

chmod 700 /home/vagrant/.ssh/id_rsa

## Gestione Inizializzazione progetti

su vagrant -c "echo -e \"Host gitlab2.serverplan.com\n\tStrictHostKeyChecking no\n\" >> /home/vagrant/.ssh/config"
su vagrant -c "mkdir /home/vagrant/Projects"

su vagrant -c "git clone git@gitlab2.serverplan.com:serverplan/devstack.git /home/vagrant/Projects/devstack"
su vagrant -c "bash /home/vagrant/Projects/devstack/stack/init-stack.sh"


## Alias

echo "alias dc=\"docker-compose\"" >> /home/vagrant/.zshrc
