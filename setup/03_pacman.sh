#!/bin/bash

echo -e "${CYAN}Configuring pacman and LTS fallback${NC}"

echo -e "${YELLOW}Making sure lts kernel is installed for fallback${NC}"
pacman -S --noconfirm --needed linux-lts linux-lts-headers

if [ ! -f "/etc/pacman.conf.bkp" ]; then
    echo -e "${YELLOW}Enabling multilib repository on pacman${NC}"

    cp /etc/pacman.conf /etc/pacman.conf.bkp
    cp ./_assets/etc/pacman.conf /etc/pacman.conf
fi
