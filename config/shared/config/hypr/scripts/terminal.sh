#!/bin/bash

TERMINAL=alacritty
active_window=$(hyprctl activewindow -j)
workspace=$(hyprctl activeworkspace -j | jq -r '.name')

if [[ "$workspace" == "docs" ]]; then
    TERMINAL=kitty
fi

if [ "$active_window" == "{}" ]; then
    $TERMINAL &
    exit 0
fi

is_fullscreen=$(echo "$active_window" | jq '.fullscreen')
if [ "$is_fullscreen" != "0" ]; then
    hyprctl dispatch fullscreen 2
fi

source "$HOME/.config/hypr/scripts/ensure_waybar.sh"

$TERMINAL &

