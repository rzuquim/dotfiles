#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/special_ws.sh"

ws_class=notes
project="nvim $HOME/Personal/notes"
open_special_ws $ws_class "alacritty --class $ws_class -e ${project}"
