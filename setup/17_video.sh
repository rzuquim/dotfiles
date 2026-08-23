#!/bin/bash

VIDEO_PACKAGES=(
    "mpv"
    "ffmpeg"
    "obs-studio"
    "screenkey"
)

echo -e "${CYAN}Installing video tools:${NC} ${VIDEO_PACKAGES[@]}"
pacman -S --noconfirm --needed ${VIDEO_PACKAGES[@]}

