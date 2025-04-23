#!/bin/bash

# TODO: passphrase prefix from install into the chroot
if [ -z ${passphrase+x} ]; then
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

if [ ! -f "/etc/hostname" ]; then
    read -rp "Enter hostname: " hostname
else
    hostname=$(cat /etc/hostname)
fi

users=("me")

read -p "Will you be gaming on this device? [Y/n] " response
response=${response:-Y}
if [[ ! $response =~ ^[Yy]$ ]]; then
    users+=("fun")
fi

read -p "Will you be streaming on this device? [Y/n] " response
response=${response:-Y}
if [[ ! $response =~ ^[Yy]$ ]]; then
    users+=("stream")
fi

