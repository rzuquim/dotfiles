#!/bin/bash

echo -e "${CYAN}Configuring pacman and LTS fallback${NC}"

if [ ! -f "/etc/pacman.conf.bkp" ]; then
    echo -e "${YELLOW}Enabling multilib repository on pacman${NC}"

    cp /etc/pacman.conf /etc/pacman.conf.bkp
    cp ./_assets/etc/pacman.conf /etc/pacman.conf

    pacman -Sy --noconfirm
fi

if ! command -v yay >/dev/null 2>&1; then
    echo -e "${YELLOW}Installing AUR helper:${NC} yay"
    if [ -d /tmp/yay ]; then
        rm -rf /tmp/yay
    fi

    # NOTE: needed to compile yay
    pacman -S --noconfirm --needed git base-devel go

    # NOTE: the build must happen on a non root user, but we need to pacman -U using the root
    #       the makepkg will fail since we are not on a interactive session
    su -s /bin/bash - me -c \
        "git clone https://aur.archlinux.org/yay.git /tmp/yay && \
        cd /tmp/yay && \
        makepkg -s"

    yay_pkg=$(ls /tmp/yay/*.zst | grep -v debug)
    if [ -z "$yay_pkg" ]; then
        echo -e "${RED}Could not find yay package build.${NC}"
        exit 1
    fi

    pacman --noconfirm --needed -U "$yay_pkg"
fi
