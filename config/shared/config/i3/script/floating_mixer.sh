#!/usr/bin/env sh

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
. "$SCRIPT_DIR/scratchpad_toggle.sh"

class="floating_mixer"
toggle_i3_class "$class" || \
    alacritty --class floating_mixer -e pulsemixer
