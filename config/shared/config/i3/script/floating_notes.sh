#!/usr/bin/env sh

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
. "$SCRIPT_DIR/scratchpad_toggle.sh"

class="floating_notes"
editor="${VISUAL:-${EDITOR:-nvim}}"
toggle_i3_class "$class" || \
    alacritty --class $class --working-directory "$HOME/Personal/notes" -e $editor
