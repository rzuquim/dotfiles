#!/bin/bash

echo -e "${CYAN}Setting up audio${NC}"
pacman -S --noconfirm --needed \
    pipewire wireplumber pipewire-audio pipewire-pulse pipewire-alsa pipewire-jack gst-plugin-pipewire libpulse \
    pulsemixer

# NOTE: enabling services
for user in "${users[@]}"; do
    user_svcs_folder=/home/$user/.config/systemd/user/default.target.wants
    mkdir -p $user_svcs_folder

    audio_svcs=(pipewire.service pipewire-pulse.service pipewire-pulse.socket wireplumber.service)

    for svc in "${audio_svcs[@]}"; do
        ln -sf "/usr/lib/systemd/user/$svc" "$user_svcs_folder/$svc"
    done
done
