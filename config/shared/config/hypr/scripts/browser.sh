#!/bin/bash

curr_workspace=$(hyprctl activeworkspace | sed -n 's/.*(\(.*\)).*/\1/p')

if [ "$curr_workspace" = "web" ]; then
    librewolf
else
    hyprctl dispatch workspace name:web
fi
