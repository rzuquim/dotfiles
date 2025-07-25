#!/bin/bash

EXIT_LOCK="/tmp/exit.lock"

if [ -f "$EXIT_LOCK" ]; then
    rm $EXIT_LOCK
    hyprctl dispatch exit
else
    touch $EXIT_LOCK
    hyprctl notify -0 5000 "rgb(ff1ea3)" "Press again to exit"
    sleep 5
    rm $EXIT_LOCK
fi

