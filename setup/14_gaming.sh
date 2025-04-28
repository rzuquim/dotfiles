#!/bin/bash

if ! id "fun" &>/dev/null; then
    echo -e "${YELLOW}Not installing fun stuff.${NC}"
    return
fi

echo -e "${CYAN}Setting up gaming${NC}"
pacman -S --noconfirm --needed \
    steam ttf-liberation gamemode lib32-gamemode mangohud lib32-mangohud

echo -e "${YELLOW}Ensuring only the gaming group can run: ${NC} steam"
chown root:gaming /usr/bin/steam
chmod 670 /usr/bin/steam

