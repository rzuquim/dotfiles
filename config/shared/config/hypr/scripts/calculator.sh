#!/bin/bash

# Check if the window exists
WIN_ID=$(hyprctl clients -j | jq -r '.[] | select(.class == "floating_calc") | .address')

if [ -z "$WIN_ID" ]; then
    hyprctl dispatch togglespecialworkspace calculator
    # NOTE: waiting a bit to ensure workspace is open before launching so we ensure focus
    sleep 0.15
    alacritty --class floating_calc -e numbat &
else
    hyprctl dispatch togglespecialworkspace calculator
fi
