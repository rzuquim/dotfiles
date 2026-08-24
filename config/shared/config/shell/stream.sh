#!/usr/bin/env sh

STREAM_MONITOR="${STREAM_MONITOR:-HDMI-1-0}"
STREAM_MODE="${STREAM_MODE:-1920x1080}"

stream_setup() {
    monitor="${1:-$STREAM_MONITOR}"

    if ! xrandr --query | /bin/grep -q "^${monitor} connected"; then
        echo "stream_setup: monitor '$monitor' is not connected" >&2
        return 1
    fi

    if ! xrandr --query |
    sed -n "/^${monitor} connected/,/^[^ ]/p" |
    /bin/grep -qE "^[[:space:]]+${STREAM_MODE}[[:space:]]"; then
        echo "stream_setup: $monitor does not support $STREAM_MODE" >&2
        return 1
    fi

    echo "Setting $monitor to $STREAM_MODE..."
    xrandr \
        --output "$monitor" \
        --mode "$STREAM_MODE"

    i3-msg reload >/dev/null 2>&1 || true

    bg_random

    echo "Streaming display configured."
}

stream_teardown() {
    monitor="${1:-$STREAM_MONITOR}"

    if ! xrandr --query | /bin/grep -q "^${monitor} connected"; then
        echo "stream_teardown: monitor '$monitor' is not connected" >&2
        return 1
    fi

    echo "Restoring $monitor to preferred mode..."
    "$HOME/.config/i3/script/monitors_and_workspaces.sh"

    echo "Display restored."
}
