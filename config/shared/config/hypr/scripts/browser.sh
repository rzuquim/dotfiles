#!/bin/bash

curr_workspace=$(hyprctl activeworkspace | sed -n 's/.*(\(.*\)).*/\1/p')

if [ "$curr_workspace" != "web" ]; then
    hyprctl dispatch workspace name:web
fi

if ! pgrep -x librewolf > /dev/null; then
    librewolf -P default
fi
