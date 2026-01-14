#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/special_ws.sh"

ws_class=file_manager

if [[ -f "$HOME/.ctx" ]]; then
    current_ws=`cat ~/.ctx | awk '{ print $2 }'`
fi

open_special_ws $ws_class "kitty --class $ws_class -e yazi $current_ws"
