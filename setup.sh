#!/bin/bash

set -euo pipefail

function already_in_dotfiles_repo() {
    dotfiles_repo_url=$(git remote get-url origin &2> /dev/null)
    echo $dotfiles_repo_url
    if [[ $dotfiles_repo_url =~ rzuquim/dotfiles.git$ ]]; then
        return 0
    else
        return 1
    fi
}

function clone_dot_files() {
    DOTFILES_REPO="$1"
    DOTFILES_LOCATION="$2"

    if [ ! -t 0 ]; then
        echo "Please run this script interactively."
        echo "bash <(curl -sL https://boot.rzuquim.com/setup.sh)"
        exit 1
    fi

    pacman-key --init
    pacman -S --noconfirm --needed archlinux-keyring

    if [ ! -d "$DOTFILES_LOCATION" ]; then
        echo -e "Installing git and cloning dotfiles"
        pacman -S --noconfirm --needed git
        git clone --depth 1 $DOTFILES_REPO $DOTFILES_LOCATION
    fi
}

function ensure_dot_files() {
    if already_in_dotfiles_repo; then
        return
    fi

    clone_dot_files https://github.com/rzuquim/dotfiles.git /tmp/dotfiles
    cd "$DOTFILES_LOCATION"
}

ensure_dot_files

pacman -Sy --noconfirm

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

echo -e "${VIOLET}SETUP DONE!${NC}"
echo "Now reboot the machine, log with the 'me' user, setup your private keys and run:"
echo "bash <(curl -sL https://boot.rzuquim.com/config.sh)"
echo

