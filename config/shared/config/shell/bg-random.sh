#!/bin/sh

function bg-random() {
    WALLPAPER_DIR="/home/.shared/wallpapers"
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
    hyprctl hyprpaper reload ,"$WALLPAPER"
}

