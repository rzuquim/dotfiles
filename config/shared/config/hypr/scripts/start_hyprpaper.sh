#!/bin/bash

WALLPAPER_DIR="/home/.shared/wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
rm -f ~/.wallpaper.jpg 
ln -s "$WALLPAPER" ~/.wallpaper.jpg 

hyprpaper &
