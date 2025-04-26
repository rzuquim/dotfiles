#!/bin/bash

curr_zoom=$(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}')

case "$1" in
    +)
        curr_zoom=$(awk "BEGIN { print ($curr_zoom / 1.25) }")
        ;;
    -)
        curr_zoom=$(awk "BEGIN { print ($curr_zoom * 1.25) }")
        ;;
    reset)
        curr_zoom=1.0
        ;;
esac

hyprctl keyword cursor:zoom_factor $curr_zoom
