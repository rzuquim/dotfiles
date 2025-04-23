#!/bin/bash

BASIC_PACKAGES=(
    "git"
    "curl"
    "7zip"
    "zip"
    "unzip"
    "unrar"
    "dos2unix"
    "base-devel"
    "which"
    "fd"
    "fzf"
    "eza"
    "ripgrep"
    "tldr"
    "tree"
    "btop"
    "ncdu"
    "openvpn"
    "bat"
    "wget"
    "less"
    "rsync"
    "git-delta"
    "wl-clipboard"
)

echo -e "${CYAN}Installing basic tools:${NC} ${BASIC_PACKAGES[@]}"
pacman -S --noconfirm --needed ${BASIC_PACKAGES[@]}
