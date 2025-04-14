#!/bin/bash

DOTFILES_REPO=git@github.com:rzuquim/dotfiles.git

# ---------------------------------
# COLORS
# ---------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN="\e[38;2;173;216;230m"
VIOLET="\e[38;2;238;130;238m"
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ ! -t 0 ]; then
    echo "Please run this script interactively."
    echo "bash <(curl -sL https://boot.rzuquim.com/arch_setup.sh)"
    exit 1
fi

echo -e "${GREEN}                           _           "
echo -e "${GREEN}                          (_)          "
echo -e "${GREEN}  _ __ _____   _  __ _ _   _ _ _ __ ___  "
echo -e "${YELLOW} | '__|_  / | | |/ _\` | | | | | '_ \` _ \ "
echo -e "${YELLOW} | |   / /| |_| | (_| | |_| | | | | | | |"
echo -e "${RED} |_|  /___|\__,_|\__, |\__,_|_|_| |_| |_|"
echo -e "${RED}                    | |                  "
echo -e "${RED}                    |_|                  ${NC}"

echo "Setting up Arch..."

if [[ -z "${WORKSPACE}" ]]; then
    WORKSPACE="/tmp/arch_install"
fi

if [ ! -d "${WORKSPACE}/dotfiles" ]; then
    echo -e "${CYAN}Installing git and cloning dotfiles${NC}"
    pacman -Sy --noconfirm --needed git
    git clone --depth 1 https://github.com/rzuquim/dotfiles.git "${WORKSPACE}/dotfiles"
    echo -e "${GREEN}DONE${NC}"
fi

cd "${WORKSPACE}/dotfiles"
# NOTE: making sure we are on the last version
git pull

source "./utils/setup_whoiam.sh"

for f in ./arch/*.sh; do
    echo -e "${CYAN}Setting up ${NC} ${f}"
    source "$f";
    echo -e "${GREEN}DONE${NC}"
done
