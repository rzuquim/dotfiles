#!/bin/bash

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
        # TODO: make it work automatically
        #   what i did to make it work properly was to append
        #   `nvidia-drm.modeset=1` on the `options` of `/boot/loader/entries/arch.conf`
        #   another promising reference: https://github.com/Obnomus/Hyprland-V2
        # TODO: check if we also need some variables on hyprland `~/.config/hypr/_environment.conf`
        # env = WLR_NO_HARDWARE_CURSORS,1
        # env = LIBVA_DRIVER_NAME,nvidia
        # env = GBM_BACKEND,nvidia-drm
        # env = __GLX_VENDOR_LIBRARY_NAME,nvidia
        # env = WLR_RENDERER_ALLOW_SOFTWARE,1
        # env = __GL_VRR_ALLOWED,0
        # TODO: another tutorial says we need to ensure `egl-wayland` is installed
    nvidia)
        pacman -S --noconfirm --needed linux-headers nvidia-dkms dkms nvidia-utils libva-nvidia-driver lib32-nvidia-utils
        ;;

    amd)
        # TODO: there are three implementations, which could be installed simultaneously:
        #   vulkan-radeon (or lib32-vulkan-radeon) - RADV (part of Mesa project)
        #   amdvlk (or lib32-amdvlk) - AMDVLK Open (maintained by AMD)
        #   vulkan-amdgpu-proAUR (or lib32-vulkan-amdgpu-proAUR) - AMDVLK Closed (maintained by AMD)
        pacman -S --noconfirm --needed \
            mesa lib32-mesa libva-mesa-driver xf86-video-amdgpu xf86-video-ati vulkan-radeon lib32-vulkan-radeon
        ;;

    intel)
        pacman -S --noconfirm --needed  \
            mesa lib32-mesa libva-intel-driver intel-media-driver vulkan-intel lib32-vulkan-intel
        ;;
esac
