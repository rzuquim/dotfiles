#!/bin/bash

BASIC_PACKAGES=(
    "git"
    "curl"
    "7zip"
    "zip"
    "unzip"
    "unrar"
    "dos2unix"
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
    "nmap"
    "prettier"
    "obsidian"
    "evtest"
    "nushell"
    "reflector"
    "fastfetch"
    "openbsd-netcat"
)

echo -e "${CYAN}Installing basic tools:${NC} ${BASIC_PACKAGES[@]}"
pacman -S --noconfirm --needed ${BASIC_PACKAGES[@]}

echo -e "${CYAN}Installing file managament tools :${NC} ${BASIC_PACKAGES[@]}"
# NOTE: yazi requires a lot of dependencies
pacman -S --noconfirm --needed yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide imagemagick
