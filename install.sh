#!/bin/bash

set -euo pipefail

DOTFILES_REPO=https://github.com/rzuquim/dotfiles.git
DOTFILES_LOCATION="/tmp/dotfiles"

if [ ! -t 0 ]; then
    echo "Please run this script interactively."
    echo "bash <(curl -sL https://boot.rzuquim.com/install.sh)"
    exit 1
fi

pacman -Sy --noconfirm

if [ ! -d "$DOTFILES_LOCATION" ]; then
    echo -e "${CYAN}Installing git and cloning dotfiles${NC}"
    pacman -S --noconfirm --needed git
    git clone --depth 1 https://github.com/rzuquim/dotfiles.git $DOTFILES_LOCATION
    echo -e "${GREEN}DONE${NC}"
fi

cd "$DOTFILES_LOCATION"

for f in ./_utils/*.sh; do
    source "$f";
done

rz_banner

echo
echo "-----------------"
echo -e "${CYAN}Bootstraping Arch${NC}"
echo "-----------------"
echo


for f in ./install/*.sh; do
    echo -e "${CYAN}Running ${NC} ${f}"
    source "$f";
    echo -e "${GREEN}DONE${NC}"
done

