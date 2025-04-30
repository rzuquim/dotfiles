#!/bin/bash

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
source "$SCRIPT_DIR/special_ws.sh"

ws_class=floating_calc
open_special_ws $ws_class "alacritty --class $ws_class -e numbat"
