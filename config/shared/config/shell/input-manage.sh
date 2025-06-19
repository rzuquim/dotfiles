#!/usr/bin/env bash

function kb-disable() {
    # TODO: this works on the asus notebook, and might not work on the avell one
    #       `sudo libinput list-devices` can capture it
    local PID_FILE="/tmp/kb_grab.pid"
    local DEVICE=$(__find_internal_kb) || {
        echo "No internal keyboard found" >&2
        return 1
    }

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

__find_internal_kb() {
    for dev in /dev/input/event*; do
        local props=$(udevadm info --query=property --name="$dev") || continue
        # NOTE: is keyboard and not usb
        if  grep -q '^ID_INPUT_KEYBOARD=1$' <<<"$props" && ! grep -q '^ID_BUS=usb$' <<<"$props"; then
            echo "$dev"
            return 0
        fi
    done
    return 1
}
