#!/bin/bash

echo -e "${CYAN}Setting up window managers:${NC} hyprland"
pacman -S --noconfirm --needed \
    hyprland xdg-desktop-portal-hyprland uwsm wofi \
    waybar power-profiles-daemon \
    slurp grim \
    hyprpaper

systemctl enable power-profiles-daemon.service
