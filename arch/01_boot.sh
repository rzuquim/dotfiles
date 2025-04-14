#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    # code to check if the basic config should be applied
    read -p "Apply boot configs? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_BOOT=true
    fi
fi


if [[ -z "$ARCH_NO_BOOT" ]]; then
    echo -e "${CYAN}Setting up boot process${NC}"

    # Microcode
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
        pacman -Sy --noconfirm "$microcode_pkg"
    fi

    # Boot loader
    if [ ! -f "/boot/loader/entries/arch.conf" ]; then
        echo -e "${YELLOW}Setting up boot loader (systemd-boot)${NC}"
        pacman -Sy --noconfirm --needed lvm2

        if [ ! -f /etc/mkinitcpio.conf.bkp ]; then
            cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bkp
        fi
        cp ./arch/assets/etc_mkinitcpio_conf /etc/mkinitcpio.conf

        mkinitcpio -P
        bootctl install

        if [ ! -f /boot/loader/loader.conf.bkp ]; then
            cp /boot/loader/loader.conf /boot/loader/loader.conf.bkp
        fi
        cp ./arch/assets/boot_loader_loader_conf /boot/loader/loader.conf

        export LUKS_PARTITION_UUID=$(blkid -t TYPE=crypto_LUKS -o value | head -n 1)
        if [[ -z "$LUKS_PARTITION_UUID" ]]; then
            echo -e "${RED}Could not find LUKS_PARTITION_UUID${NC}"
            exit 1
        fi

        envsubst < ./arch/assets/boot_loader_entries_arch_conf > /boot/loader/entries/arch.conf
        envsubst < ./arch/assets/boot_loader_entries_arch_lts_conf > /boot/loader/entries/arch_lts.conf
    fi
fi

