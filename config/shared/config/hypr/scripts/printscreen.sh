#!/bin/bash

PRINTSCREEN_DIR="$HOME/Pictures/Prints"
mkdir -p $PRINTSCREEN_DIR
grim -g "$(slurp)" - | tee "$PRINTSCREEN_DIR/$(date +%Y-%m-%d_%H-%M-%S).png" | wl-copy

