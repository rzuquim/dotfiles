#!/bin/bash

if [ ! -f "/etc/hostname" ]; then
    read -rp "Enter hostname: " hostname
else
    hostname=$(cat /etc/hostname)
fi

users=("me")

if ! id "fun" &>/dev/null; then
    read -p "Will you be gaming on this device? [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Yy]$ ]]; then
        users+=("fun")
    fi
else
    users+=("fun")
fi

if ! id "stream" &>/dev/null; then
    read -p "Will you be streaming on this device? [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Yy]$ ]]; then
        users+=("stream")
    fi
else
    users+=("stream")
fi

echo -e "${YELLOW}Users:${NC} ${users[@]}"

if ! all_users_have_passphrase "${users[@]}" ; then
    echo -e "${YELLOW}Enter a passphrase prefix:${NC}"
    echo "(It will be used for disk encryption and for the user's passwords)"
    read -s -p "Passphrase: " passphrase
    echo
    read -s -p "Confirm passphrase: " passphrase_confirm
    echo

    if [[ "$passphrase" != "$passphrase_confirm" ]]; then
        echo -e "${RED}Passphrases do not match. Aborting.${NC}"
        exit 1
    fi
fi

if [ ! -d "/home/.shared" ]; then
    echo -e "${CYAN}Configuring .configs:${NC} shared"
    mkdir /home/.shared
    chown -R root:root /home/.shared
fi

GIT_WHO_AM_I="/home/me/.config/git/whoami.toml"

if [ ! -f "$GIT_WHO_AM_I" ]; then
    MY_EMAIL=rzuquim@gmail.com
    MY_NAME="Rafael Zuquim"

    read -p "Are you me? [Y/n] " response

    response=${response:-Y}
    if [[ $response =~ ^[Nn]$ ]]; then
        echo -e "${CYAN}Setting up main user${NC}"

        read -p "Please enter your email: " MY_EMAIL
        read -p "Please enter your first and last names: " MY_NAME
    fi
else
    MY_EMAIL=$(head -n 1 $GIT_WHO_AM_I)
    MY_NAME=$(tail -n 1 $GIT_WHO_AM_I)
fi
