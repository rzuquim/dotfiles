#!/bin/bash

export EDITOR="$VISUAL"
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.dotnet/bin:$PATH
export BROWSER="librewolf"

# display manager
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_TYPE=wayland
export GDK_BACKEND=wayland,x11
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland,x11
export MOZ_ENABLE_WAYLAND=1

# history
export HISTFILE=~/.config/.zsh_history
export HISTSIZE=100
export SAVEHIST=1000
export HISTCONTROL=ignoreboth # ignoring history duplicate

# mobile dev
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# caching users
export UID=$(id -u)
export GID=$(id -g)

