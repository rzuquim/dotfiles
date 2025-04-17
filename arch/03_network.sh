#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    # code to check if the basic config should be applied
    read -p "Apply network configs? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_NETWORK=true
    fi
fi

if [[ -z "$ARCH_NO_NETWORK" ]]; then
    echo -e "${CYAN}Installing network manager${NC}"

    pacman -Sy --noconfirm --needed networkmanager
    systemctl enable NetworkManager
    nmcli radio wifi on
fi
