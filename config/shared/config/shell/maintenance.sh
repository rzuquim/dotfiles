#!/usr/bin/env bash

arch_maintenance() {
    set -e

    echo "==> Updating official repositories"
    sudo pacman -Syu

    # if command -v yay >/dev/null 2>&1; then
    #     echo
    #     echo "==> Updating AUR packages"
    #     yay -Sua
    # fi

    echo
    echo "==> Cleaning pacman cache"
    if command -v paccache >/dev/null 2>&1; then
        sudo paccache -r
    else
        echo "paccache not found. Install pacman-contrib:"
        echo "  sudo pacman -S pacman-contrib"
    fi

    echo
    echo "==> Failed system units"
    systemctl --failed || true

    echo
    echo "==> Failed user units"
    systemctl --user --failed || true

    echo
    echo "==> Orphan packages"
    pacman -Qdt || true

    echo
    echo "==> Recent high-priority boot logs"
    journalctl -p 3 -xb --no-pager || true

    echo
    echo "==> Maintenance complete"
}

arch_mirrors() {
    sudo pacman-key --refresh-keys

    sudo reflector \
        --country Brazil \
        --country Chile \
        --country "United States" \
        --protocol https \
        --age 48 \
        --latest 50 \
        --sort rate \
        --number 15 \
        --save /etc/pacman.d/mirrorlist
}
