#!/bin/bash

# Check if the window exists
WIN_ID=$(hyprctl clients -j | jq -r '.[] | select(.class == "scratchpad") | .address')

if [ -z "$WIN_ID" ]; then
    hyprctl dispatch togglespecialworkspace scratchpad
    # NOTE: waiting a bit to ensure workspace is open before launching so we ensure focus
    sleep 0.15
    alacritty --class scratchpad &
else
    hyprctl dispatch togglespecialworkspace scratchpad
fi
