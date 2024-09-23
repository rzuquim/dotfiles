#!/bin/bash
#
# Command list
# gsettings list-recursively org.gnome.shell.extensions.pop-shell

# Example
# gsettings set org.gnome.desktop.wm.keybindings switch-windows "[]"
# gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab']"

gsettings set org.gnome.shell.keybindings focus-active-notification "[]" 
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>n']"

gsettings set org.gnome.shell.extensions.pop-shell tile-enter "['<Super>KP_Enter']"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "['<Super>Return']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"

gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4', '<Super>w']"
gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>q']"

gsettings set org.gnome.desktop.wm.keybindings maximize "['']"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>Down']"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>Up']"

gsettings set org.gnome.shell.extensions.pop-shell focus-up "['<Super>k']"
gsettings set org.gnome.shell.extensions.pop-shell focus-down "['<Super>j']"
gsettings set org.gnome.shell.extensions.pop-shell focus-left "['<Super>h']"
gsettings set org.gnome.shell.extensions.pop-shell focus-right "['<Super>l']"

# FIX: not working
# gsettings set org.gnome.shell.extensions.pop-shell tile-swap-left "['<Super>Left']"
# gsettings set org.gnome.shell.extensions.pop-shell tile-swap-right "['<Super>Right']"

# ---------------------------------
# DEFAULT KEYBINDINGS
# ---------------------------------
# org.gnome.shell.keybindings focus-active-notification ['<Super>n']
# org.gnome.shell.keybindings toggle-application-view ['<Super>a']
# org.gnome.shell.keybindings toggle-message-tray ['<Super>v']
# org.gnome.shell.keybindings toggle-overview ['<Super>d']
#
# org.gnome.shell.extensions.pop-shell activate-launcher ['<Super>slash']
# org.gnome.shell.extensions.pop-shell active-hint false
# org.gnome.shell.extensions.pop-shell active-hint-border-radius uint32 0
# org.gnome.shell.extensions.pop-shell column-size uint32 64
# org.gnome.shell.extensions.pop-shell focus-down ['<Super>Down', '<Super>KP_Down', '<Super>j']
# org.gnome.shell.extensions.pop-shell focus-left ['<Super>Left', '<Super>KP_Left', '<Super>h']
# org.gnome.shell.extensions.pop-shell focus-right ['<Super>Right', '<Super>KP_Right', '<Super>l']
# org.gnome.shell.extensions.pop-shell focus-up ['<Super>Up', '<Super>KP_Up', '<Super>k']
# org.gnome.shell.extensions.pop-shell fullscreen-launcher false
# org.gnome.shell.extensions.pop-shell gap-inner uint32 0
# org.gnome.shell.extensions.pop-shell gap-outer uint32 0
# org.gnome.shell.extensions.pop-shell hint-color-rgba 'rgb(251,114,108)'
# org.gnome.shell.extensions.pop-shell log-level uint32 0
# org.gnome.shell.extensions.pop-shell management-orientation ['o']
# org.gnome.shell.extensions.pop-shell mouse-cursor-focus-location uint32 0
# org.gnome.shell.extensions.pop-shell mouse-cursor-follows-active-window true
# org.gnome.shell.extensions.pop-shell pop-monitor-down ['<Super><Shift><Primary>Down', '<Super><Shift><Primary>KP_Down', '<Super><Shift><Primary>j']
# org.gnome.shell.extensions.pop-shell pop-monitor-left ['<Super><Shift>Left', '<Super><Shift>KP_Left', '<Super><Shift>h']
# org.gnome.shell.extensions.pop-shell pop-monitor-right ['<Super><Shift>Right', '<Super><Shift>KP_Right', '<Super><Shift>l']
# org.gnome.shell.extensions.pop-shell pop-monitor-up ['<Super><Shift><Primary>Up', '<Super><Shift><Primary>KP_Up', '<Super><Shift><Primary>k']
# org.gnome.shell.extensions.pop-shell pop-workspace-down ['<Super><Shift>Down', '<Super><Shift>KP_Down', '<Super><Shift>j']
# org.gnome.shell.extensions.pop-shell pop-workspace-up ['<Super><Shift>Up', '<Super><Shift>KP_Up', '<Super><Shift>k']
# org.gnome.shell.extensions.pop-shell row-size uint32 64
# org.gnome.shell.extensions.pop-shell show-skip-taskbar true
# org.gnome.shell.extensions.pop-shell show-stack-tab-buttons true
# org.gnome.shell.extensions.pop-shell show-title true
# org.gnome.shell.extensions.pop-shell smart-gaps false
# org.gnome.shell.extensions.pop-shell snap-to-grid false
# org.gnome.shell.extensions.pop-shell stacking-with-mouse true
# org.gnome.shell.extensions.pop-shell tile-accept ['Return', 'KP_Enter']
# org.gnome.shell.extensions.pop-shell tile-by-default true
# org.gnome.shell.extensions.pop-shell tile-enter ['<Super>Return', '<Super>KP_Enter']
# org.gnome.shell.extensions.pop-shell tile-move-down ['Down', 'KP_Down', 'j']
# org.gnome.shell.extensions.pop-shell tile-move-down-global @as []
# org.gnome.shell.extensions.pop-shell tile-move-left ['Left', 'KP_Left', 'h']
# org.gnome.shell.extensions.pop-shell tile-move-left-global @as []
# org.gnome.shell.extensions.pop-shell tile-move-right ['Right', 'KP_Right', 'l']
# org.gnome.shell.extensions.pop-shell tile-move-right-global @as []
# org.gnome.shell.extensions.pop-shell tile-move-up ['Up', 'KP_Up', 'k']
# org.gnome.shell.extensions.pop-shell tile-move-up-global @as []
# org.gnome.shell.extensions.pop-shell tile-orientation ['<Super>o']
# org.gnome.shell.extensions.pop-shell tile-reject ['Escape']
# org.gnome.shell.extensions.pop-shell tile-resize-down ['<Shift>Down', '<Shift>KP_Down', '<Shift>j']
# org.gnome.shell.extensions.pop-shell tile-resize-left ['<Shift>Left', '<Shift>KP_Left', '<Shift>h']
# org.gnome.shell.extensions.pop-shell tile-resize-right ['<Shift>Right', '<Shift>KP_Right', '<Shift>l']
# org.gnome.shell.extensions.pop-shell tile-resize-up ['<Shift>Up', '<Shift>KP_Up', '<Shift>k']
# org.gnome.shell.extensions.pop-shell tile-swap-down ['<Primary>Down', '<Primary>KP_Down', '<Primary>j']
# org.gnome.shell.extensions.pop-shell tile-swap-left ['<Primary>Left', '<Primary>KP_Left', '<Primary>h']
# org.gnome.shell.extensions.pop-shell tile-swap-right ['<Primary>Right', '<Primary>KP_Right', '<Primary>l']
# org.gnome.shell.extensions.pop-shell tile-swap-up ['<Primary>Up', '<Primary>KP_Up', '<Primary>k']
# org.gnome.shell.extensions.pop-shell toggle-floating ['<Super>g']
# org.gnome.shell.extensions.pop-shell toggle-stacking ['s']
# org.gnome.shell.extensions.pop-shell toggle-stacking-global ['<Super>s']
# org.gnome.shell.extensions.pop-shell toggle-tiling ['<Super>y']
#
# org.gnome.desktop.wm.keybindings activate-window-menu ['<Alt>space']
# org.gnome.desktop.wm.keybindings always-on-top @as []
# org.gnome.desktop.wm.keybindings begin-move ['<Alt>F7']
# org.gnome.desktop.wm.keybindings begin-resize ['<Alt>F8']
# org.gnome.desktop.wm.keybindings cycle-group ['<Alt>F6']
# org.gnome.desktop.wm.keybindings cycle-group-backward ['<Shift><Alt>F6']
# org.gnome.desktop.wm.keybindings cycle-panels-backward ['<Shift><Control><Alt>Escape']
# org.gnome.desktop.wm.keybindings cycle-panels ['<Control><Alt>Escape']
# org.gnome.desktop.wm.keybindings cycle-windows ['<Alt>Escape']
# org.gnome.desktop.wm.keybindings cycle-windows-backward ['<Shift><Alt>Escape']
# org.gnome.desktop.wm.keybindings lower @as []
# org.gnome.desktop.wm.keybindings maximize @as []
# org.gnome.desktop.wm.keybindings maximize-horizontally @as []
# org.gnome.desktop.wm.keybindings maximize-vertically @as []
# org.gnome.desktop.wm.keybindings minimize @as []
# org.gnome.desktop.wm.keybindings move-to-center @as []
# org.gnome.desktop.wm.keybindings move-to-corner-ne @as []
# org.gnome.desktop.wm.keybindings move-to-corner-nw @as []
# org.gnome.desktop.wm.keybindings move-to-corner-se @as []
# org.gnome.desktop.wm.keybindings move-to-corner-sw @as []
# org.gnome.desktop.wm.keybindings move-to-monitor-down @as []
# org.gnome.desktop.wm.keybindings move-to-monitor-left @as []
# org.gnome.desktop.wm.keybindings move-to-monitor-right @as []
# org.gnome.desktop.wm.keybindings move-to-monitor-up @as []
# org.gnome.desktop.wm.keybindings move-to-side-e @as []
# org.gnome.desktop.wm.keybindings move-to-side-n @as []
# org.gnome.desktop.wm.keybindings move-to-side-s @as []
# org.gnome.desktop.wm.keybindings move-to-side-w @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-1 ['<Super><Shift>Home']
# org.gnome.desktop.wm.keybindings move-to-workspace-10 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-11 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-12 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-2 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-3 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-4 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-5 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-6 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-7 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-8 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-9 @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-down @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-last ['<Super><Shift>End']
# org.gnome.desktop.wm.keybindings move-to-workspace-left @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-right @as []
# org.gnome.desktop.wm.keybindings move-to-workspace-up @as []
# org.gnome.desktop.wm.keybindings panel-main-menu @as []
# org.gnome.desktop.wm.keybindings panel-run-dialog ['<Alt>F2']
# org.gnome.desktop.wm.keybindings raise @as []
# org.gnome.desktop.wm.keybindings raise-or-lower @as []
# org.gnome.desktop.wm.keybindings set-spew-mark @as []
# org.gnome.desktop.wm.keybindings show-desktop @as []
# org.gnome.desktop.wm.keybindings switch-applications-backward ['<Shift><Super>Tab', '<Shift><Alt>Tab']
# org.gnome.desktop.wm.keybindings switch-applications ['<Super>Tab', '<Alt>Tab']
# org.gnome.desktop.wm.keybindings switch-group-backward ['<Shift><Super>Above_Tab', '<Shift><Alt>Above_Tab']
# org.gnome.desktop.wm.keybindings switch-group ['<Super>Above_Tab', '<Alt>Above_Tab']
# org.gnome.desktop.wm.keybindings switch-input-source-backward ['<Shift><Super>space', '<Shift>XF86Keyboard']
# org.gnome.desktop.wm.keybindings switch-input-source ['<Super>space', 'XF86Keyboard']
# org.gnome.desktop.wm.keybindings switch-panels-backward ['<Shift><Control><Alt>Tab']
# org.gnome.desktop.wm.keybindings switch-panels ['<Control><Alt>Tab']
# org.gnome.desktop.wm.keybindings switch-to-workspace-10 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-11 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-12 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-1 ['<Super>Home']
# org.gnome.desktop.wm.keybindings switch-to-workspace-2 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-3 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-4 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-5 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-6 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-7 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-8 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-9 @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-down ['<Primary><Super>Down', '<Primary><Super>KP_Down', '<Primary><Super>j']
# org.gnome.desktop.wm.keybindings switch-to-workspace-last ['<Super>End']
# org.gnome.desktop.wm.keybindings switch-to-workspace-left @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-right @as []
# org.gnome.desktop.wm.keybindings switch-to-workspace-up ['<Primary><Super>Up', '<Primary><Super>KP_Up', '<Primary><Super>k']
# org.gnome.desktop.wm.keybindings switch-windows @as []
# org.gnome.desktop.wm.keybindings switch-windows-backward @as []
# org.gnome.desktop.wm.keybindings toggle-above @as []
# org.gnome.desktop.wm.keybindings toggle-fullscreen @as []
# org.gnome.desktop.wm.keybindings toggle-maximized ['<Super>m']
# org.gnome.desktop.wm.keybindings toggle-on-all-workspaces @as []
# org.gnome.desktop.wm.keybindings toggle-shaded @as []
# org.gnome.desktop.wm.keybindings unmaximize @as []
# org.gnome.settings-daemon.plugins.media-keys battery-status ['']
# org.gnome.settings-daemon.plugins.media-keys battery-status-static ['XF86Battery']
# org.gnome.settings-daemon.plugins.media-keys calculator ['']
# org.gnome.settings-daemon.plugins.media-keys calculator-static ['XF86Calculator']
# org.gnome.settings-daemon.plugins.media-keys control-center ['']
# org.gnome.settings-daemon.plugins.media-keys control-center-static ['XF86Tools']
# org.gnome.settings-daemon.plugins.media-keys custom-keybindings ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/PopLaunch1/']
# org.gnome.settings-daemon.plugins.media-keys decrease-text-size ['']
# org.gnome.settings-daemon.plugins.media-keys eject ['']
# org.gnome.settings-daemon.plugins.media-keys eject-static ['XF86Eject']
# org.gnome.settings-daemon.plugins.media-keys email-static ['XF86Mail']
# org.gnome.settings-daemon.plugins.media-keys email ['<Super>e']
# org.gnome.settings-daemon.plugins.media-keys help ['', '<Super>F1']
# org.gnome.settings-daemon.plugins.media-keys hibernate ['']
# org.gnome.settings-daemon.plugins.media-keys hibernate-static ['XF86Suspend', 'XF86Hibernate']
# org.gnome.settings-daemon.plugins.media-keys home-static ['XF86Explorer']
# org.gnome.settings-daemon.plugins.media-keys home ['<Super>f']
# org.gnome.settings-daemon.plugins.media-keys increase-text-size ['']
# org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-down ['']
# org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-down-static ['XF86KbdBrightnessDown']
# org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-toggle ['']
# org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-toggle-static ['XF86KbdLightOnOff']
# org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-up ['']
# org.gnome.settings-daemon.plugins.media-keys keyboard-brightness-up-static ['XF86KbdBrightnessUp']
# org.gnome.settings-daemon.plugins.media-keys logout ['<Control><Alt>Delete']
# org.gnome.settings-daemon.plugins.media-keys magnifier ['<Alt><Super>8']
# org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-in ['<Alt><Super>equal']
# org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-out ['<Alt><Super>minus']
# org.gnome.settings-daemon.plugins.media-keys media ['']
# org.gnome.settings-daemon.plugins.media-keys media-static ['XF86AudioMedia']
# org.gnome.settings-daemon.plugins.media-keys mic-mute ['']
# org.gnome.settings-daemon.plugins.media-keys mic-mute-static ['XF86AudioMicMute']
# org.gnome.settings-daemon.plugins.media-keys next ['']
# org.gnome.settings-daemon.plugins.media-keys next-static ['XF86AudioNext', '<Ctrl>XF86AudioNext']
# org.gnome.settings-daemon.plugins.media-keys on-screen-keyboard ['']
# org.gnome.settings-daemon.plugins.media-keys pause ['']
# org.gnome.settings-daemon.plugins.media-keys pause-static ['XF86AudioPause']
# org.gnome.settings-daemon.plugins.media-keys play ['']
# org.gnome.settings-daemon.plugins.media-keys playback-forward ['']
# org.gnome.settings-daemon.plugins.media-keys playback-forward-static ['XF86AudioForward']
# org.gnome.settings-daemon.plugins.media-keys playback-random ['']
# org.gnome.settings-daemon.plugins.media-keys playback-random-static ['XF86AudioRandomPlay']
# org.gnome.settings-daemon.plugins.media-keys playback-repeat ['']
# org.gnome.settings-daemon.plugins.media-keys playback-repeat-static ['XF86AudioRepeat']
# org.gnome.settings-daemon.plugins.media-keys playback-rewind ['']
# org.gnome.settings-daemon.plugins.media-keys playback-rewind-static ['XF86AudioRewind']
# org.gnome.settings-daemon.plugins.media-keys play-static ['XF86AudioPlay', '<Ctrl>XF86AudioPlay']
# org.gnome.settings-daemon.plugins.media-keys power ['']
# org.gnome.settings-daemon.plugins.media-keys power-static ['XF86PowerOff']
# org.gnome.settings-daemon.plugins.media-keys previous ['']
# org.gnome.settings-daemon.plugins.media-keys previous-static ['XF86AudioPrev', '<Ctrl>XF86AudioPrev']
# org.gnome.settings-daemon.plugins.media-keys rfkill ['']
# org.gnome.settings-daemon.plugins.media-keys rfkill-bluetooth ['']
# org.gnome.settings-daemon.plugins.media-keys rfkill-bluetooth-static ['XF86Bluetooth']
# org.gnome.settings-daemon.plugins.media-keys rfkill-static ['XF86WLAN', 'XF86UWB', 'XF86RFKill']
# org.gnome.settings-daemon.plugins.media-keys rotate-video-lock ['']
# org.gnome.settings-daemon.plugins.media-keys rotate-video-lock-static ['XF86RotationLockToggle']
# org.gnome.settings-daemon.plugins.media-keys screen-brightness-cycle ['']
# org.gnome.settings-daemon.plugins.media-keys screen-brightness-cycle-static ['XF86MonBrightnessCycle']
# org.gnome.settings-daemon.plugins.media-keys screen-brightness-down ['']
# org.gnome.settings-daemon.plugins.media-keys screen-brightness-down-static ['XF86MonBrightnessDown']
# org.gnome.settings-daemon.plugins.media-keys screen-brightness-up ['']
# org.gnome.settings-daemon.plugins.media-keys screen-brightness-up-static ['XF86MonBrightnessUp']
# org.gnome.settings-daemon.plugins.media-keys screenreader ['<Alt><Super>s']
# org.gnome.settings-daemon.plugins.media-keys screensaver-static ['XF86ScreenSaver']
# org.gnome.settings-daemon.plugins.media-keys screensaver ['<Super>Escape']
# org.gnome.settings-daemon.plugins.media-keys search ['']
# org.gnome.settings-daemon.plugins.media-keys search-static ['XF86Search']
# org.gnome.settings-daemon.plugins.media-keys stop ['']
# org.gnome.settings-daemon.plugins.media-keys stop-static ['XF86AudioStop']
# org.gnome.settings-daemon.plugins.media-keys suspend ['']
# org.gnome.settings-daemon.plugins.media-keys suspend-static ['XF86Sleep']
# org.gnome.settings-daemon.plugins.media-keys terminal ['<Super>t']
# org.gnome.settings-daemon.plugins.media-keys toggle-contrast ['']
# org.gnome.settings-daemon.plugins.media-keys touchpad-off ['']
# org.gnome.settings-daemon.plugins.media-keys touchpad-off-static ['XF86TouchpadOff']
# org.gnome.settings-daemon.plugins.media-keys touchpad-on ['']
# org.gnome.settings-daemon.plugins.media-keys touchpad-on-static ['XF86TouchpadOn']
# org.gnome.settings-daemon.plugins.media-keys touchpad-toggle ['']
# org.gnome.settings-daemon.plugins.media-keys touchpad-toggle-static ['XF86TouchpadToggle', '<Ctrl><Super>XF86TouchpadToggle']
# org.gnome.settings-daemon.plugins.media-keys volume-down ['']
# org.gnome.settings-daemon.plugins.media-keys volume-down-precise ['']
# org.gnome.settings-daemon.plugins.media-keys volume-down-precise-static ['<Shift>XF86AudioLowerVolume', '<Ctrl><Shift>XF86AudioLowerVolume']
# org.gnome.settings-daemon.plugins.media-keys volume-down-quiet ['']
# org.gnome.settings-daemon.plugins.media-keys volume-down-quiet-static ['<Alt>XF86AudioLowerVolume', '<Alt><Ctrl>XF86AudioLowerVolume']
# org.gnome.settings-daemon.plugins.media-keys volume-down-static ['XF86AudioLowerVolume', '<Ctrl>XF86AudioLowerVolume']
# org.gnome.settings-daemon.plugins.media-keys volume-mute ['']
# org.gnome.settings-daemon.plugins.media-keys volume-mute-quiet ['']
# org.gnome.settings-daemon.plugins.media-keys volume-mute-quiet-static ['<Alt>XF86AudioMute']
# org.gnome.settings-daemon.plugins.media-keys volume-mute-static ['XF86AudioMute']
# org.gnome.settings-daemon.plugins.media-keys volume-step 6
# org.gnome.settings-daemon.plugins.media-keys volume-up ['']
# org.gnome.settings-daemon.plugins.media-keys volume-up-precise ['']
# org.gnome.settings-daemon.plugins.media-keys volume-up-precise-static ['<Shift>XF86AudioRaiseVolume', '<Ctrl><Shift>XF86AudioRaiseVolume']
# org.gnome.settings-daemon.plugins.media-keys volume-up-quiet ['']
# org.gnome.settings-daemon.plugins.media-keys volume-up-quiet-static ['<Alt>XF86AudioRaiseVolume', '<Alt><Ctrl>XF86AudioRaiseVolume']
# org.gnome.settings-daemon.plugins.media-keys volume-up-static ['XF86AudioRaiseVolume', '<Ctrl>XF86AudioRaiseVolume']
# org.gnome.settings-daemon.plugins.media-keys www-static ['XF86WWW']
# org.gnome.settings-daemon.plugins.media-keys www ['<Super>b']
# org.gnome.settings-daemon.plugins.power ambient-enabled true
# org.gnome.settings-daemon.plugins.power idle-brightness 30
# org.gnome.settings-daemon.plugins.power idle-dim true
# org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'
# org.gnome.settings-daemon.plugins.power lid-close-battery-action 'suspend'
# org.gnome.settings-daemon.plugins.power lid-close-suspend-with-external-monitor false
# org.gnome.settings-daemon.plugins.power power-button-action 'interactive'
# org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery true
# org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1800
# org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
# org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1800
# org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend'

