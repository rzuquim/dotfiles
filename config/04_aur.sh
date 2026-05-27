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
    "commitizen-go"
)

yay -S --needed ${YAY_PACKAGES[@]}

echo
echo "-----------------"
echo -e "${CYAN}Installing other tools${NC} (some shit is easier when installed using native methods)"
echo "-----------------"

DOTNET_TOOLS=(
    "csharpier"
    # "dotnet-counters"
)

for TOOL in "${DOTNET_TOOLS[@]}"; do
    if dotnet tool list -g | /bin/grep -qi "$TOOL"; then
        dotnet tool update -g "$TOOL"
    else
        dotnet tool install -g "$TOOL"
    fi
done

