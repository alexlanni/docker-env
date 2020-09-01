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



