#!/bin/bash

echo -e "${CYAN}Installing bluetooth${NC}"
pacman -S --noconfirm --needed bluez bluez-utils

# TODO: bluetuith (AUR)
#
if [ ! -f /etc/bluetooth/main.conf.bkp ]; then
    systemctl enable bluetooth.service
    cp  /etc/bluetooth/main.conf /etc/bluetooth/main.conf.bkp
fi
cp ./_assets/etc/bluetooth/main.conf /etc/bluetooth/main.conf
