#!/bin/bash

function clip() {
    if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        wl-copy "$@"
    elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
        xclip -selection clipboard "$@"
    else
        echo "Unsupported session type: $XDG_SESSION_TYPE" >&2
        return 1
    fi
}
