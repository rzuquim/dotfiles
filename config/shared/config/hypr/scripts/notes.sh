#!/bin/bash

# Check if the window exists
WIN_ID=$(hyprctl clients -j | jq -r '.[] | select(.class == "notes") | .address')

if [ -z "$WIN_ID" ]; then
    hyprctl dispatch togglespecialworkspace notes
    # NOTE: waiting a bit to ensure workspace is open before launching so we ensure focus
    sleep 0.15
    alacritty --class notes -e "nvim ~/personal/notes" &
else
    hyprctl dispatch togglespecialworkspace notes
fi
