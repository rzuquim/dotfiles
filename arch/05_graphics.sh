#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    read -p "Install graphics dependencies? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_GRAPHICS=true
    fi
fi

if [[ -z "$ARCH_NO_GRAPHICS" ]]; then
    gpu_info=$(lspci | grep -Ei "VGA|3D")
    gpu_vendor="unknown"

    if echo "$gpu_info" | grep -iq "nvidia"; then
        gpu_vendor="nvidia"
    elif echo "$gpu_info" | grep -iq "amd"; then
        gpu_vendor="amd"
    elif echo "$gpu_info" | grep -iq "intel"; then
        gpu_vendor="intel"
    fi

    if [ "$gpu_vendor" = "unknown" ]; then
        echo -e "${RED}Could not detect the gpu vendor!${NC}"
        exit 1
    fi

    echo -e "${CYAN}Installing graphics drivers for:${NC} $gpu_vendor"

    case "$gpu_vendor" in
        nvidia)
            pacman -Sy --noconfirm --needed nvidia-dkms dkms nvidia-utils libva-nvidia-driver lib32-nvidia-utils
            ;;

        amd)
            pacman -Sy --noconfirm --needed \
                mesa lib32-mesa libva-mesa-driver xf86-video-amdgpu xf86-video-ati vulkan-radeon lib32-vulkan-radeon
            ;;

        intel)
            pacman -Sy --noconfirm --needed  \
                mesa lib32-mesa libva-intel-driver intel-media-driver vulkan-intel lib32-vulkan-intel
            ;;
    esac
fi
