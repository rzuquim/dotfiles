#!/bin/bash

echo -e "${CYAN}Setting up basic localization${NC}"

if [ ! -e /etc/localtime ]; then
    echo -e "${YELLOW}Setting up clock${NC}"

    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    hwclock --systohc
fi

if [ ! -f "/etc/locale.gen.bkp" ]; then
    echo -e "${YELLOW}Setting up locale${NC}"

    cp /etc/locale.gen /etc/locale.gen.bkp
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
    echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen

    echo "LANG=en_US.UTF-8" > /etc/locale.conf
fi

if [ ! -f "/etc/vconsole.conf" ]; then
    echo -e "${YELLOW}Setting up console settings${NC}"

    echo "KEYMAP=br-abnt2" > /etc/vconsole.conf
    echo "FONT=ter-132n" >> /etc/vconsole.conf

    pacman -S --noconfirm --needed terminus-font
fi

