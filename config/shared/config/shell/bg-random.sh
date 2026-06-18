#!/usr/bin/env bash

bg_random() {
    WALLPAPER_DIR="/home/.shared/wallpapers"
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        hyprctl hyprpaper preload "$WALLPAPER"
        hyprctl hyprpaper wallpaper ",$WALLPAPER"
    elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
        feh --bg-fill "$WALLPAPER"
    else
        echo "Error: Unknown session type '$XDG_SESSION_TYPE'" >&2
        return 1
    fi
}
