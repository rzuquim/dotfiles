#!/usr/bin/env bash

function keyboard-disable() {
    xinput list | awk -F '\t' '/AT/ {print $2} ' | awk -F '=' '{print $2}' | xargs xinput disable
    setxkbmap us -variant intl
}

function keyboard-enable() {
    xinput list | awk -F '\t' '/AT/ {print $2} ' | awk -F '=' '{print $2}' | xargs xinput enable
    setxkbmap br -variant abnt2
}

function keylang-toggle() {
    case $(setxkbmap -query | grep layout | awk '{ print $2; exit }') in
        us) setxkbmap br -variant abnt2 ;;
        br) setxkbmap us -variant intl ;;
        *) setxkbmap us -variant intl ;;
    esac
}

function touchpad-toggle() {
    local TRACKPAD_ID=$(xinput list | /bin/grep -i 'TouchPad\|TrackPad' | /bin/grep -oP 'id=\K\d+')
    local ENABLED=$(xinput list-props $TRACKPAD_ID | /bin/grep 'Device Enabled' | awk '{print $4}')

    if [[ "$ENABLED" == "1" ]]; then
        xinput disable $TRACKPAD_ID
        echo "Trackpad disabled."
    else
        xinput enable $TRACKPAD_ID
        echo "Trackpad enabled."
    fi
}
