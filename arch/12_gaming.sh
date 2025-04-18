#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    read -p "Install gaming platform? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_GAMING=true
    fi
fi

if [[ -z "$ARCH_NO_GAMING" ]]; then
    echo -e "${CYAN}Setting up gaming${NC}"
    pacman -S --noconfirm --needed \
        steam ttf-liberation gamemode lib32-gamemode mangohud lib32-mangohud vulkan-tools
fi

