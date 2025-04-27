#!/bin/bash

active_window=$(hyprctl activewindow -j)
is_fullscreen=$(echo "$active_window" | jq '.fullscreen')
if [ "$is_fullscreen" != "0" ]; then
    hyprctl dispatch fullscreen 2
fi

source "$HOME/.config/hypr/scripts/ensure_waybar.sh"

alacritty &

