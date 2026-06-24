#!/usr/bin/env bash

function kb-enable() {
    case "$XDG_SESSION_TYPE" in
        x11)
            __x11_kb-enable
            echo "Keyboard enabled on X11"
            ;;

        wayland)
            __wayland_kb-enable
            echo "Keyboard enabled on Wayland"
            ;;

        *)
            echo "Unsupported or unknown session type: $XDG_SESSION_TYPE" >&2
            return 1
            ;;
    esac
}

function kb-disable() {
    case "$XDG_SESSION_TYPE" in
        x11)
            __x11_kb-disable
            echo "Keyboard enabled on X11"
            ;;

        wayland)
            __wayland_kb-disable
            echo "Keyboard enabled on Wayland"
            ;;

        *)
            echo "Unsupported or unknown session type: $XDG_SESSION_TYPE" >&2
            return 1
            ;;
    esac
}

__x11_kb-enable() {
    xinput list | awk -F '\t' '/AT/ {print $2} ' | awk -F '=' '{print $2}' | xargs xinput enable
    setxkbmap br -variant abnt2
}


__x11_kb-disable() {
    xinput list | awk -F '\t' '/AT/ {print $2} ' | awk -F '=' '{print $2}' | xargs xinput disable
    setxkbmap us -variant intl
}

__wayland_kb-disable() {
    local PID_FILE="/tmp/kb_grab.pid"
    local DEVICE

    DEVICE=$(__select_keyboard) || {
        echo "No keyboard selected" >&2
        return 1
    }

    if [[ -f "$PID_FILE" ]]; then
        echo "Keyboard already disabled"
        return 1
    fi

    # NOTE: pre-authenticating in foreground
    sudo -v || return 1

    nohup sudo evtest --grab "$DEVICE" > /dev/null 2>&1 &
    echo $! > "$PID_FILE"

    echo "Keyboard disabled: $DEVICE"
}

__wayland_kb-enable() {
    local PID_FILE="/tmp/kb_grab.pid"
    local PID

    # NOTE: pre-authenticating in foreground
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

__select_keyboard() {
    command -v fzf >/dev/null || {
        echo "fzf is required" >&2
        return 1
    }

    local selection

    selection=$(
        for dev in /dev/input/event*; do
            udevadm info --query=property --name="$dev" 2>/dev/null |
            grep -q '^ID_INPUT_KEYBOARD=1$' || continue

            printf '%s\n' "$dev"
        done |
        fzf \
            --prompt="Select keyboard: " \
            --preview='udevadm info --query=property --name={} 2>/dev/null' \
            --preview-window=right:70%:wrap
    ) || return 1

    [[ -n "$selection" ]] || return 1

    printf '%s\n' "$selection"
}
