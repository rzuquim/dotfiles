#!/bin/sh

function focus_window() {
    local hyprland_filter=$1

    # if no ":" in input → default to class:
    [[ "$hyprland_filter" != *:* ]] && hyprland_filter="class:$hyprland_filter"

    echo "$hyprland_filter"

    hyprctl --batch "dispatch focuswindow $hyprland_filter; dispatch bringactivetotop"
}

