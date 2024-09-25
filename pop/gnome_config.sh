#!/bin/bash

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

gsettings set org.gnome.desktop.interface enable-animations false

# Disable the default Print Screen shortcut
gsettings set org.gnome.shell.keybindings show-screenshot-ui '[]'
gsettings set org.gnome.shell.keybindings screenshot-window '[]'
gsettings set org.gnome.shell.keybindings screenshot '[]'

gsettings set org.gnome.GWeather temperature-unit centigrade

