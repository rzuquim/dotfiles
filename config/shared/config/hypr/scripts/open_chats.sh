#!/bin/bash

wasistlos &
Telegram &

chats=("wasistlos" "org.telegram.desktop")

wait_for_windows() {
    local i=0
    while true; do
        found_all=true
        for app in "${chats[@]}"; do
            if ! hyprctl clients -j | grep -q "$app"; then
                found_all=false
                break
            fi
        done
        $found_all && break
        sleep 0.5
        i=$((i + 1))
        if [ i -gt 10 ]; then
            echo "Timeout waiting for chats to appear" >> /tmp/startup_error.log
            exit -1
        fi
    done
}

wait_for_windows

addresses=()
for app in "${chats[@]}"; do
    address=$(hyprctl clients -j | jq -r ".[] | select(.class == \"${app}\") | .address")
    [ -n "$address" ] && addresses+=("$address")
done

if [ ${#addresses[@]} -ge 2 ]; then
    hyprctl dispatch focuswindow address:${addresses[0]}
    hyprctl dispatch togglegroup

    for ((i = 1; i < ${#addresses[@]}; i++)); do
        hyprctl dispatch focuswindow address:${addresses[i]}
        hyprctl dispatch togglegroup
        hyprctl dispatch moveintogroup l
    done
fi

