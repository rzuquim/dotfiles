#!/bin/bash

echo -e "${CYAN}Setting up window managers:${NC} hyprland"
pacman -S --noconfirm --needed \
    hyprland xdg-desktop-portal-hyprland uwsm rofi \
    waybar power-profiles-daemon \
    slurp grim \
    hyprpaper hyprlock swaync hyprpicker \
    copyq

systemctl enable power-profiles-daemon.service
