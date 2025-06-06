#!/bin/bash

if [ ! -f "/etc/hostname" ]; then
    read -rp "Enter hostname: " hostname
else
    hostname=$(cat /etc/hostname)
fi

USER_LIST_FILE="/etc/keys/users"

if [ ! -f $USER_LIST_FILE ]; then
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

    if ! id "write" &>/dev/null; then
        read -p "Will you be writing on this machine? [Y/n] " response
        response=${response:-Y}
        if [[ $response =~ ^[Yy]$ ]]; then
            users+=("write")
        fi
    else
        users+=("write")
    fi

    if ! id "server" &>/dev/null; then
        read -p "Will you be using this machine as a server? [Y/n] " response
        response=${response:-Y}
        if [[ $response =~ ^[Yy]$ ]]; then
            users+=("server")
        fi
    else
        users+=("server")
    fi

    echo "${users[@]}" > $USER_LIST_FILE
else
    echo -e "${YELLOW}Loading user list from${NC} $USER_LIST_FILE"
    echo -e "${VIOLET}Delete it if you want to change it.${NC}"
    users=($(cat $USER_LIST_FILE))
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
    MY_EMAIL=$(sed -n '2p' $GIT_WHO_AM_I)
    MY_NAME=$(tail -n 1 $GIT_WHO_AM_I)
fi

if [ ! -d "/home/me/Personal" ]; then
    mkdir /home/me/Personal
fi

if id "write" &>/dev/null; then
    cp -r "$GIT_WHO_AM_I" "/home/write/.config/git/whoami.toml"

    if [ ! -d "/home/write/Personal" ]; then
        mkdir -p /home/write/Personal
    fi

    if [ ! -d "/home/write/Education" ]; then
        mkdir -p /home/write/Education
    fi
fi
