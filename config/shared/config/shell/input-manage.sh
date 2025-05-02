#!/usr/bin/env bash

function kb-disable() {
    # TODO: this works on the asus notebook, and might not work on the avell one
    #       `sudo libinput list-devices` can capture it
    local DEVICE="/dev/input/event4"
    local PID_FILE="/tmp/kb_grab.pid"

    if [[ -f "$PID_FILE" ]]; then
        echo "Keyboard already disabled"
        return 1
    fi

    # NOTE: pre-autenticating in foreground
    sudo -v || return 1
    nohup sudo evtest --grab "$DEVICE" > /dev/null 2>&1 &
    echo $! > "$PID_FILE"
    echo "Keyboard disabled!"
}

function kb-enable() {
    local PID_FILE="/tmp/kb_grab.pid"

    # NOTE: pre-autenticating in foreground
    sudo -v || return 1

    if [[ -f "$PID_FILE" ]]; then
        PID=$(cat "$PID_FILE")
        rm -f "$PID_FILE"

        if ps -p "$PID" > /dev/null; then
            sudo kill "$PID"
            echo "Keyboard enabled!"
        else
            echo "No running grab process found."
        fi
        return 0
    fi

    echo "Keyboard already enabled"
    return 1
}
