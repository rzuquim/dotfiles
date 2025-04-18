#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    read -p "Install audio? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_AUDIO=true
    fi
fi

if [[ -z "$ARCH_NO_AUDIO" ]]; then
    echo -e "${CYAN}Setting up audio${NC}"
    pacman -S --noconfirm --needed \
        pipewire wireplumber pipewire-audio pipewire-pulse pipewire-alsa pipewire-jack gst-plugin-pipewire libpulse

    pacman -S --noconfirm --needed \
        pulsemixer

    users=(me stream fun)

    # NOTE: enbling services
    for user in "${users[@]}"; do
        user_svcs_folder=/home/$user/.config/systemd/user/default.target.wants
        mkdir -p $user_svcs_folder

        audio_svcs=(pipewire.service pipewire-pulse.service pipewire-pulse.socket wireplumber.service)

        for svc in "${audio_svcs[@]}"; do
            ln -sf "/usr/lib/systemd/user/$svc" "$user_svcs_folder/$svc"
        done
    done
fi

