#!/bin/bash

is_fullscreen=$(echo "$active_window" | jq '.fullscreen')

if [ "$is_fullscreen" != "0" ]; then
    hyprctl dispatch fullscreen 0
    pkill -USR1 waybar
else
    hyprctl dispatch fullscreen 2
    pkill -USR2 waybar
fi
