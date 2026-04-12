#!/usr/bin/env bash

set -euo pipefail

WIN_ADDR=$(hyprctl activewindow -j | jq -r '.address')

if [[ -z "$WIN_ADDR" || "$WIN_ADDR" == "null" ]]; then
    exit 0
fi

WORKSPACE_LIST=$(hyprctl workspaces -j | jq -r '.[] | "\(.name)"')

CHOICE=$(\
        echo "$WORKSPACE_LIST" | \
    rofi -i -theme ~/.config/rofi/config.rasi -matching=fuzzy -dmenu -mesg "Move window to workspace")

if [[ -z "$CHOICE" ]]; then
    exit 0
fi

hyprctl dispatch movetoworkspace "name:$CHOICE,address:$WIN_ADDR"
