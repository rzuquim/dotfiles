#!/bin/bash

DOTFILES_REPO=git@github.com:rzuquim/dotfiles.git

# ---------------------------------
# COLORS
# ---------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN="\e[38;2;173;216;230m"
INDIGO="\e[38;2;75;0;130m"
VIOLET="\e[38;2;238;130;238m"
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ ! -t 0 ]; then
    echo "Please run this script interactively."
    echo ". <(curl -sL https://raw.githubusercontent.com/rzuquim/dotfiles/master/bootstrap/pop.sh)"
    exit 1
fi

echo -e "${GREEN}                           _           "
echo -e "${GREEN}                          (_)          "
echo -e "${GREEN}  _ __ _____   _  __ _ _   _ _ _ __ ___  "
echo -e "${YELLOW} | '__|_  / | | |/ _\` | | | | | '_ \` _ \ "
echo -e "${YELLOW} | |   / /| |_| | (_| | |_| | | | | | | |"
echo -e "${RED} |_|  /___|\__,_|\__, |\__,_|_|_| |_| |_|"
echo -e "${RED}                    | |                  "
echo -e "${RED}                    |_|                  ${NC}"

echo "Bootstraping POP! OS"

if [ ! -d ~/.rzuquim ]; then
    mkdir -p ~/.rzuquim
fi

WORKSPACE=~/.rzuquim
WHOAMI_FILE=$WORKSPACE/whoami
MY_EMAIL=rzuquim@gmail.com
MY_NAME="Rafael Zuquim"
if [ ! -f $WHOAMI_FILE ]; then
    read -p "Are you me? [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Nn]$ ]]; then
        read -p "Please enter your email: " MY_EMAIL
        read -p "Please enter your first and last names: " MY_NAME
    fi

    echo "$MY_EMAIL" > $WHOAMI_FILE
    echo "$MY_NAME" >> $WHOAMI_FILE
else
    MY_EMAIL=$(head -n 1 $WHOAMI_FILE)
    MY_NAME=$(tail -n 1 $WHOAMI_FILE)
    echo "Welcome back $MY_NAME ($MY_EMAIL)!"
fi
echo

# ---------------------------------
# KNOWN HOSTS
# ---------------------------------
KNOWN_HOSTS_FILE=~/.ssh/known_hosts

if [ ! -d ~/.ssh ]; then
    echo -e "${CYAN}Creating .ssh folder${NC}"
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
fi

# Check if github.com is already in known_hosts
if [ ! -f "$KNOWN_HOSTS_FILE" ] || ! grep -q "^github.com " "$KNOWN_HOSTS_FILE"; then
    echo -e "${CYAN}Adding github.com to known_hosts${NC}"
    ssh-keyscan github.com >> "$KNOWN_HOSTS_FILE"
fi

# ---------------------------------
# CLONING dotfiles
# ---------------------------------
CLONE_SUCCESSFUL=false

mkdir -p $WORKSPACE
pushd $WORKSPACE

while [ "$CLONE_SUCCESSFUL" == false ]; do
    echo "Trying to clone $DOTFILES_REPO"
    git clone --depth 1 $DOTFILES_REPO

    if [ $? -eq 0 ]; then
        break
    fi

    echo -e "${RED}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${NC}"
    echo -e "${RED}Could not clone dotfiles repository!${NC}"
    echo -e "${RED}!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${NC}"

    # Check if an SSH key already exists
    if [ ! -f ~/.ssh/id_ed25519 ]; then
        echo -e "${CYAN}No SSH key found. Generating a new SSH key...${NC}"
        ssh-keygen -t ed25519 -C "$MY_EMAIL" -f ~/.ssh/id_ed25519
        echo -e "${GREEN}SSH key generated and added to the ssh-agent.${NC}"
        echo
    fi

    echo -e "${YELLOW}Copy your public key to your GitHub account (Ctrl+Shift+C):${NC}"
    echo -e "${YELLOW}https://github.com/settings/ssh/new${NC}"
    echo
    while IFS= read -r line; do
        echo -e "${RED}$line${NC}"
    done < "$HOME/.ssh/id_ed25519.pub"
    echo
    read -n 1 -s -r -p "After adding the key on GitHub, press any key to try again..."
done

echo -e "${VIOLET}---------------------------------${NC}"
echo -e "${VIOLET}dotfiles cloned${NC}"
echo -e "${VIOLET}---------------------------------${NC}"

cd dotfiles
source ./init_pop.sh

