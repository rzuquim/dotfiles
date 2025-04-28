#!/bin/bash

active_window=$(hyprctl activewindow -j)

if [ "$active_window" == "{}" ]; then
    if ! pgrep -x waybar > /dev/null; then
        waybar &
    fi
    exit 0
fi

is_fullscreen=$(echo "$active_window" | jq '.fullscreen')

if [ "$is_fullscreen" == "0" ]; then
    if ! pgrep -x waybar > /dev/null; then
        waybar &
    fi
    return
fi

killall waybar
