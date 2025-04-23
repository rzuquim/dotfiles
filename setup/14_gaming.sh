#!/bin/bash

if ! id "fun" &>/dev/null; then
    echo -e "${YELLOW}Not installing fun stuff.${NC}"
fi

echo -e "${CYAN}Setting up gaming${NC}"
pacman -S --noconfirm --needed \
    steam ttf-liberation gamemode lib32-gamemode mangohud lib32-mangohud vulkan-tools
