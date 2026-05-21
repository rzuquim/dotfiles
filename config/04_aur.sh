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

    "rider"

    "screenplain"
    "ocrmypdf"

    "ttf-symbola"
    "ttf-unifont"
    "ttf-dejavu"
    "noto-fonts-extra"

    "unityhub"

    "pureref"
    "csharpier"
    "commitizen-go"
)

yay -S --needed ${YAY_PACKAGES[@]}
