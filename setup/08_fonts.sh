#!/bin/bash

echo -e "${CYAN}Installing nice fonts${NC}"

FONTS_PACKAGES=(
    "ttf-font-awesome"
    "ttf-cascadia-code-nerd"
    "ttf-fira-code"
    "ttf-firacode-nerd"
    "ttf-hack"
    "ttf-jetbrains-mono"
)

pacman -S --noconfirm --needed ${FONTS_PACKAGES[@]}
