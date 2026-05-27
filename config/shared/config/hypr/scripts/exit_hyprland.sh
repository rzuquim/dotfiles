#!/bin/bash

EXIT_LOCK="/tmp/exit.lock"

if [ -f "$EXIT_LOCK" ]; then
    rm -f "$EXIT_LOCK"
    uwsm stop
else
    touch "$EXIT_LOCK"
    hyprctl notify -0 5000 "rgb(ff1ea3)" "Press again to exit"
    sleep 5
    rm -f "$EXIT_LOCK"
fi
