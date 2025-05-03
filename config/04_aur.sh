#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Installing AUR stuff${NC} (cannot install as root on previous scripts)"
echo "-----------------"

YAY_PACKAGES=(
    "bluetuith"
    "librewolf-bin"
    "brave-bin"
    "whatsapp-for-linux"
    "telegram-desktop"
    "numbat-bin"
    "zsa-keymapp-bin"
)

yay -S --needed ${YAY_PACKAGES[@]}
