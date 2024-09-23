#!/bin/bash

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 6

# Disable the default Print Screen shortcut
gsettings set org.gnome.shell.keybindings show-screenshot-ui '[]'
gsettings set org.gnome.shell.keybindings screenshot-window '[]'
gsettings set org.gnome.shell.keybindings screenshot '[]'

# Default notifications toggle moved to <Super>n (so <Super>v can handle the clipboard history)
gsettings set org.gnome.shell.keybindings focus-active-notification "[]"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n']"
