#!/usr/bin/env bash

# adding MS repo (TODO: if not exists /etc/apt/trusted.gpg.d/packages.microsoft.gpg)

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

# updating apt
sudo apt update

# installing basic apps
sudo apt install apt-transport-https -y
sudo apt install git-all -y
sudo apt install xclip -y
sudo apt install vim -y
sudo apt install ca-certificates -y
sudo apt install curl -y
sudo apt install gnupg -y
sudo apt install lsb-release -y
sudo apt install pip -y
sudo apt install tmux -y
sudo apt install filezilla -y

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb

# removing firefox
sudo apt-get purge firefox

# telegram
sudo add-apt-repository ppa:atareao/telegram
sudo apt update && sudo apt install telegram

# docker (TODO: conditional / adding repo before apt update)
sudo apt-get remove docker docker-engine docker.io containerd runc
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo groupadd docker
sudo usermod -aG docker $USER
pip install docker-compose

# teams
wget –O teams.deb https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.5153_amd64.deb
sudo apt install ./teams_1.3.00.5153_amd64.deb
rm ./teams_1.3.00.5153_amd64.deb

# z
mkdir -p ~/apps/z
wget -O ~/apps/z/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh

# exa

# open-vpn
sudo apt-get install openvpn

# gnome

sudo apt install gnome-tweaks -y
sudo apt install chrome-gnome-shell -y
sudo apt install gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor

# fira code
sudo add-apt-repository universe
sudo apt update
sudo apt install fonts-firacode

#spotify

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get install spotify-client

# vlc
sudo apt install vlc

# logs
sudo apt install glogg
