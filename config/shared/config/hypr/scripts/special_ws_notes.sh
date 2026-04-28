#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/special_ws.sh"

ws_class=notes
project="nvim ."
open_special_ws $ws_class "alacritty --class $ws_class --working-directory "$HOME/Personal/notes" -e ${project}"
