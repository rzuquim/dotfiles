#!/bin/bash

function open_special_ws() {
    local ws_class=$1
    local cmd=$2

    local instance=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$ws_class\")")

    if [ -z "$instance" ]; then
        bash -c "$cmd" &
    else
        local id=$(echo $instance | jq -r ".address")
        local ws=$(echo $instance | jq -r ".workspace.name")
        local current_ws=$(hyprctl activeworkspace -j | jq -r ".name")

        if [ "$ws" == "$current_ws" ]; then
            hyprctl dispatch focuswindow address:$id \
                && hyprctl dispatch movetoworkspacesilent special
        else
            hyprctl dispatch focuswindow address:$id \
                && hyprctl dispatch movetoworkspace "name:$current_ws"
        fi
    fi
}

