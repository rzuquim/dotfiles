#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/special_ws.sh"

ws_class=file_manager
open_special_ws $ws_class "kitty --class $ws_class -e yazi"
