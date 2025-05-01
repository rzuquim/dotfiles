#!/bin/bash

TERM=alacritty
active_window=$(hyprctl activewindow -j)
workspace=$(hyprctl activeworkspace -j | jq -r '.name')

if [[ "$workspace" == "docs" ]]; then
    TERM=kitty
fi

if [ "$active_window" == "{}" ]; then
    $TERM &
    exit 0
fi

is_fullscreen=$(echo "$active_window" | jq '.fullscreen')
if [ "$is_fullscreen" != "0" ]; then
    hyprctl dispatch fullscreen 2
fi

source "$HOME/.config/hypr/scripts/ensure_waybar.sh"

$TERM &

