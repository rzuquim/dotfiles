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

