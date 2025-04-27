#!/bin/bash

hyprctl dispatch workspace $1

source "$HOME/.config/hypr/scripts/ensure_waybar.sh"
