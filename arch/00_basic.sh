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
    echo -e "${INDIGO}Setting up basic localization${NC}"

    ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
    hwclock --systohc

    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

    # more basic stuff here
fi
