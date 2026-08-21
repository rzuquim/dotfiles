#!/usr/bin/env bash

set -euo pipefail

BG='#1a1b26'
FG='#c0caf5'
BLUE='#7aa2f7'
CYAN='#7dcfff'
PURPLE='#bb9af7'
GREEN='#9ece6a'
RED='#f7768e'
YELLOW='#e0af68'

i3lock \
    --ignore-empty-password \
    --color="$BG"

# SRC="$HOME/.wallpaper.jpg"
# LOCK="/tmp/i3lock-${USER}.png"
# FONT="$(fc-match -f '%{file}\n' 'FiraCode Nerd Font' | head -n1)"

# magick "$SRC" \
    #     -resize "$(xdpyinfo | awk '/dimensions:/ {print $2}')^" \
    #     -gravity center \
    #     -extent "$(xdpyinfo | awk '/dimensions:/ {print $2}')" \
    #     -fill '#c0caf5' \
    #     -font "$FONT" \
    #     -pointsize 34 \
    #     -gravity north \
    #     -annotate +0+150 "$(date '+%A, %-d %B %Y')" \
    #     -pointsize 18 \
    #     -gravity south \
    #     -annotate +0+100 "   $USER" \
    #     "$LOCK"
#
# i3lock \
    #     --ignore-empty-password \
    #     --image="$LOCK"
# i3lock \
    #     --ignore-empty-password \
    #     --image="$HOME/.wallpaper.png" \
    #     --tiling
#
# rm -f "$LOCK"
# LOCK="/tmp/i3lock-${USER}.png"

# magick "$HOME/.wallpaper.jpg" "$LOCK"
#
# i3lock \
    #     --ignore-empty-password \
    #     --image="$LOCK" \
    #     --tiling

# rm -f "$LOCK"
