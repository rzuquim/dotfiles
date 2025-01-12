#!/bin/bash
#
# Command list
# /bin/ls /usr/share/glib-2.0/schemas | gsettings list-recursively | grep "Query"

gsettings set org.gnome.shell.keybindings focus-active-notification "[]" 
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n']"

gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super>KP_Enter']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"

gsettings set org.gnome.desktop.wm.keybindings close "['<Super>w']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>q']"

gsettings set org.gnome.desktop.wm.keybindings maximize "['']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up']"

gsettings set org.gnome.shell.extensions.pop-shell focus-left "['<Super>h']"
gsettings set org.gnome.shell.extensions.pop-shell focus-down "['<Super>j']"
gsettings set org.gnome.shell.extensions.pop-shell focus-up "['<Super>k']"
gsettings set org.gnome.shell.extensions.pop-shell focus-right "['<Super>l']"

# Adjust tiles
gsettings set org.gnome.shell.keybindings toggle-application-view "['']"
gsettings set org.gnome.shell.extensions.pop-shell tile-orientation "['']"

gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super>a']"
gsettings set org.gnome.shell.extensions.pop-shell tile-accept "['Return']"

gsettings set org.gnome.shell.extensions.pop-shell tile-move-left "['Left']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-down "['Down']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-up "['Up']"
gsettings set org.gnome.shell.extensions.pop-shell tile-move-right "['Right']"

