#!/usr/bin/env sh

terminal_class="Alacritty"
curr_workspace

ws_chat="3:chat"
ws_aux="4:aux"

curr_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

case "$curr_workspace" in
    "$ws_chat"|"$ws_aux")
        terminal_class="AlacrittyOpaque"
        ;;
esac

alacritty --class "$terminal_class"
