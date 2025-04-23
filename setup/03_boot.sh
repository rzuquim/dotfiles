#!/bin/bash

echo -e "${CYAN}Setting up boot process${NC}"

cpu_vendor=$(lscpu | grep -E '^Vendor ID:' | awk '{print $3}')
if [[ "$cpu_vendor" == "GenuineIntel" ]]; then
    microcode_pkg="intel-ucode"
    export MICROCODE_IMG="/intel-ucode.img"
elif [[ "$cpu_vendor" == "AuthenticAMD" ]]; then
    microcode_pkg="amd-ucode"
    export MICROCODE_IMG="/amd-ucode.img"
else
    echo -e "${RED}Unsupported CPU vendor: $cpu_vendor. Skipping microcode installation.${NC}"
fi

if ! pacman -Q "$microcode_pkg" &>/dev/null; then
    echo -e "${YELLOW}Setting up CPU microcode updates${NC}"
    pacman -S --noconfirm "$microcode_pkg"
fi

if [ ! -f "/boot/loader/entries/arch.conf" ]; then
    echo -e "${YELLOW}Setting up boot loader${NC} systemd-boot"
    pacman -S --noconfirm --needed lvm2

    if [ ! -f /etc/mkinitcpio.conf.bkp ]; then
        cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bkp
    fi
    cp ./_assets/etc/mkinitcpio.conf /etc/mkinitcpio.conf


    mkinitcpio -p linux
    mkinitcpio -p linux-lts

    if [ ! -f /boot/loader/loader.conf ]; then
        bootctl install
    fi

    if [ ! -f /boot/loader/loader.conf.bkp ]; then
        cp /boot/loader/loader.conf /boot/loader/loader.conf.bkp
    fi
    cp ./_assets/boot/loader/loader.conf /boot/loader/loader.conf

    # NOTE: we are assuming that the first nvme device will hold the root
    LUKS_PARTITION_UUID=$(blkid -t TYPE=crypto_LUKS | sort | grep nvme | head -n1 | cut -d'"' -f2)

    if [[ -z "$LUKS_PARTITION_UUID" ]]; then
        echo -e "${YELLOW}No NVMe LUKS device found. Falling back to first available LUKS partition...${NC}"
        LUKS_PARTITION_UUID=$(blkid -t TYPE=crypto_LUKS | sort | head -n1 | cut -d'"' -f2)
    fi

    if [[ -z "$LUKS_PARTITION_UUID" ]]; then
        echo -e "${RED}Could not find any LUKS partition UUID.${NC}"
        exit 1
    fi

    export LUKS_PARTITION_UUID="$LUKS_PARTITION_UUID"
    envsubst < ./_assets/boot/loader/entries/arch.conf > /boot/loader/entries/arch.conf
    envsubst < ./_assets/boot/loader/entries/arch_lts.conf > /boot/loader/entries/arch_lts.conf
fi
