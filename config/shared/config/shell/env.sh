#!/bin/bash

export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.dotnet/bin:$PATH
export BROWSER="librewolf"
export TERMINAL="alacritty"

# history
export HISTFILE=~/.config/.zsh_history
export HISTSIZE=100
export SAVEHIST=1000
export HISTCONTROL=ignoreboth # ignoring history duplicate

#game dev (unity)
export PATH=$PATH:$HOME/.dotnet/tools

# mobile dev
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# llm
export LLM_HOME=$HOME/.config/clanker/

# caching users
export UID=$(id -u)
export GID=$(id -g)

xorg_envs() {
    export XDG_SESSION_TYPE=x11
    export XDG_CURRENT_DESKTOP=i3
    export DESKTOP_SESSION=i3

    export GDK_BACKEND=x11
    export QT_QPA_PLATFORM=xcb
    export SDL_VIDEODRIVER=x11
    export MOZ_ENABLE_WAYLAND=0

    # NOTE: add gpu variables if needed
}

wayland_envs() {
    export XDG_SESSION_TYPE=wayland
    export XDG_CURRENT_DESKTOP=Hyprland
    export DESKTOP_SESSION=Hyprland

    export GDK_BACKEND="wayland,x11"
    export QT_QPA_PLATFORM="wayland;xcb"
    export SDL_VIDEODRIVER="wayland,x11"
    export MOZ_ENABLE_WAYLAND=1

    # NOTE: GPU-specific setup
    gpu_info="$(lspci | /bin/grep -Ei 'VGA|3D')"

    if echo "$gpu_info" | grep -iq "nvidia"; then
        export GBM_BACKEND=nvidia-drm
        export WLR_NO_HARDWARE_CURSORS=1
        export WLR_RENDERER_ALLOW_SOFTWARE=1
        export LIBVA_DRIVER_NAME=nvidia
        export VDPAU_DRIVER=nvidia
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __GL_VRR_ALLOWED=0

    elif echo "$gpu_info" | grep -iq "amd"; then
        # NOTE: unset unless we have a specific VAAPI/VDPAU problem
        # export LIBVA_DRIVER_NAME=radeonsi
        # export VDPAU_DRIVER=radeonsi

    elif echo "$gpu_info" | grep -iq "intel"; then
        # NOTE: unset unless we have a specific VAAPI/VDPAU problem
        # export LIBVA_DRIVER_NAME=iHD
        # export VDPAU_DRIVER=va_gl
    fi
}
