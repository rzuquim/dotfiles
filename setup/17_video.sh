#!/bin/bash

VIDEO_PACKAGES=(
    "mpv"
    "ffmpeg"
)

echo -e "${CYAN}Installing video tools:${NC} ${VIDEO_PACKAGES[@]}"
pacman -S --noconfirm --needed ${VIDEO_PACKAGES[@]}

if ! id "stream" &>/dev/null; then
    echo -e "${YELLOW}Not installing streaming stuff.${NC}"
    return
fi

STREAMING_PACKAGES=(
    "obs-studio"
)

echo -e "${CYAN}Installing streaming tools:${NC} ${STREAMING_PACKAGES[@]}"
pacman -S --noconfirm --needed ${STREAMING_PACKAGES[@]}
