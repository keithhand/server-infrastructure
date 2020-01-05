#! /usr/bin/env sh

# Add ansible to apt sources
sudo echo 'deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main' >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update

# Install ansible
sudo apt -y install ansible
