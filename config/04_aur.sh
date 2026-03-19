#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Installing AUR stuff${NC} (cannot install as root on previous scripts)"
echo "-----------------"

YAY_PACKAGES=(
    "bluetuith"
    "librewolf-bin"
    "google-chrome"
    "whatsapp-for-linux"
    "telegram-desktop"
    "numbat-bin"
    "zsa-keymapp-bin"
    "zoom"
    "ldtk"
    "vagrant"

    "screenplain"
    "ocrmypdf"

    "ttf-symbola"
    "ttf-unifont"
    "ttf-dejavu"
    "noto-fonts-extra"

    "unityhub"

    "pureref"
)

yay -S --needed ${YAY_PACKAGES[@]}
