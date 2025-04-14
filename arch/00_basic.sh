#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    # code to check if the basic config should be applied
    read -p "Apply basic configs? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_BASIC=true
    fi
fi


if [[ -z "$ARCH_NO_BASIC" ]]; then
    echo -e "${YELLOW}Setting up basic localization${NC}"

    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    hwclock --systohc

    if [ ! -f "/etc/locale.gen.bkp" ]; then
        cp /etc/locale.gen /etc/locale.gen.bkp
        echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
        echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
        locale-gen
    fi

    if [ ! -f "/etc/locale.conf" ]; then
        echo "LANG=en_US.UTF-8" > /etc/locale.conf
    fi

    if [ ! -f "/etc/vconsole.conf" ]; then
        echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
        echo "FONT=lat9w-16" >> /etc/vconsole.conf
    fi

    echo -e "${YELLOW}Setting hostname and hosts file${NC}"
    if [ ! -f "/etc/hostname" ]; then
        read -rp "Enter hostname: " hostname
        echo "$hostname" > /etc/hostname
        export hostname="$hostname"
        # NOTE: assuming this is running from git folder
        envsubst < ./arch/assets/etc_hosts > /etc/hosts
    fi

    # more basic stuff here
fi
