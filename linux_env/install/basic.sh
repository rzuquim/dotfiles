#!/usr/bin/env bash

# adding MS repo (TODO: if not exists /etc/apt/trusted.gpg.d/packages.microsoft.gpg)

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# updating apt
sudo apt update

# installing basic apps
sudo apt install \ 
  apt-transport-https \
  git-all \
  xclip \
  vim \
  ca-certificates \
  curl \
  gnupg \
  lsb-release \
  pip \
  tmux

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

# flatpak

sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# telegram

sudo add-apt-repository ppa:atareao/telegram
sudo apt update && sudo apt install telegram

# removing firefox
sudo apt-get purge firefox

# docker (TODO: conditional / adding repo before apt update)
sudo apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo groupadd docker
sudo usermod -aG docker $USER