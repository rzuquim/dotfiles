#!/bin/bash

echo -e "${CYAN}Installing network manager${NC}"

pacman -S --noconfirm --needed networkmanager
systemctl enable NetworkManager

if nmcli -t -f TYPE device | grep -q '^wifi$'; then
    echo -e "${YELLOW}Turning on WIFI${NC}"
    nmcli radio wifi on
fi

