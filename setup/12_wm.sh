#!/bin/bash

echo -e "${CYAN}Setting up window managers:${NC} hyprland and i3"

pacman -S --noconfirm --needed \
    hyprland xdg-desktop-portal-hyprland uwsm rofi \
    waybar power-profiles-daemon \
    slurp grim \
    hyprpaper hyprlock swaync hyprpicker \
    copyq

pacman -S --noconfirm --needed \
    xorg-server xorg-xinit xdg-desktop-portal i3-wm i3status \
    picom xclip polybar flameshot \
    dunst feh

# maim/slop/xclip vs fireshot

systemctl enable power-profiles-daemon.service

