#!/bin/bash

active_window=$(hyprctl activewindow -j)

if [ "$active_window" == "{}" ]; then
    exit 0
fi

is_fullscreen=$(echo "$active_window" | jq '.fullscreen')

if [ "$is_fullscreen" != "0" ]; then
    hyprctl dispatch fullscreen 0
    waybar &
else
    hyprctl dispatch fullscreen 2
    killall waybar
fi
