#!/bin/bash

set -euo pipefail

DOTFILES_REPO=https://github.com/rzuquim/dotfiles.git
DOTFILES_LOCATION="/tmp/dotfiles"

if [ ! -t 0 ]; then
    echo "Please run this script interactively."
    echo "bash <(curl -sL https://boot.rzuquim.com/setup.sh)"
    exit 1
fi

pacman-key --init
pacman -Sy --noconfirm
pacman -S --noconfirm archlinux-keyring

if [ ! -d "$DOTFILES_LOCATION" ]; then
    echo -e "Installing git and cloning dotfiles"
    pacman -S --noconfirm --needed git
    git clone --depth 1 https://github.com/rzuquim/dotfiles.git $DOTFILES_LOCATION
fi

cd "$DOTFILES_LOCATION"

for f in ./_utils/*.sh; do
    source "$f";
done

rz_banner

echo
echo "-----------------"
echo -e "${CYAN}Setting up Arch${NC}"
echo "-----------------"

for f in ./setup/*.sh; do
    echo
    echo -e "${CYAN}Running ${NC} ${f}"
    source "$f";
    echo -e "${GREEN}DONE${NC}"
    echo
done

