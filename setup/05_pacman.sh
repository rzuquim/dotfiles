#!/bin/bash

echo -e "${CYAN}Configuring pacman and LTS fallback${NC}"

if [ ! -f "/etc/pacman.conf.bkp" ]; then
    echo -e "${YELLOW}Enabling multilib repository on pacman${NC}"

    cp /etc/pacman.conf /etc/pacman.conf.bkp
    cp ./_assets/etc/pacman.conf /etc/pacman.conf

    pacman -Sy --noconfirm
fi

if ! command -v paru >/dev/null 2>&1; then
    echo -e "${YELLOW}Installing AUR helper:${NC} paru"
    if [ -d /tmp/paru ]; then
        rm -rf /tmp/paru
    fi

    # NOTE: needed to compile paru
    pacman -S --noconfirm --needed rustup base-devel

    # NOTE: the build must happen on a non root user, but we need to pacman -U using the root
    #       the makepkg will fail since we are not on a interactive session
    su -s /bin/bash - me -c \
        "rustup default stable && \
        git clone --depth 1 https://aur.archlinux.org/paru.git /tmp/paru && \
        cd /tmp/paru && makepkg -s"

    paru_pkg=$(ls /tmp/paru/*.zst | grep -v debug)
    if [ -z "$paru_pkg" ]; then
        echo -e "${RED}Could not find paru package build.${NC}"
        exit 1
    fi

    pacman --noconfirm --needed -U "$paru_pkg"
fi
