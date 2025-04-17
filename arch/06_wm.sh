#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    read -p "Install window manager? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_WM=true
    fi
fi

if [[ -z "$ARCH_NO_WM" ]]; then
    echo -e "${CYAN}Setting up window managers:${NC} hyprland"
    pacman -S --noconfirm --needed hyprland xdg-desktop-portal-hyprland uwsm wofi
fi
