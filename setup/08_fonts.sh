#!/bin/bash

echo -e "${CYAN}Installing nice fonts${NC}"

FONTS_PACKAGES=(
    "ttf-font-awesome"
    "ttf-cascadia-code-nerd"
    "ttf-fira-code"
    "ttf-fira-code-nerd"
    "ttf-hack"
    "ttf-jetbrains-mono"
    "terminus-font"
)

pacman -S --noconfirm --needed ${FONTS_PACKAGES[@]}
