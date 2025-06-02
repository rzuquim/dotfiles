#!/bin/bash

VIDEO_PACKAGES=(
    "mpv"
    "ffmpeg"
)

echo -e "${CYAN}Installing video tools:${NC} ${VIDEO_PACKAGES[@]}"
pacman -S --noconfirm --needed ${VIDEO_PACKAGES[@]}

