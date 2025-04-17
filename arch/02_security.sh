#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    # code to check if the basic config should be applied
    read -p "Apply boot configs? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_SECURITY=true
    fi
fi


if [[ -z "$ARCH_NO_SECURITY" ]]; then
    echo -e "${CYAN}Setting up sudo${NC}"
    pacman -S --noconfirm --needed sudo

    if [ ! -f /etc/sudoers.bkp ]; then
        cp /etc/sudoers /etc/sudoers.bkp
    fi
    cp ./arch/assets/etc_sudoers /etc/sudoers

    echo -e "${CYAN}Setting up firewall (nftables)${NC}"
    pacman -S --noconfirm --needed nftables
    systemctl enable nftables


    if [ ! -f /etc/nftables.conf.bkp ]; then
        cp  /etc/nftables.conf /etc/nftables.conf.bkp
    fi
    cp ./arch/assets/etc_nftables_conf /etc/nftables.conf

    echo -e "${CYAN}Setting up SSH (using TOTP)${NC}"
    pacman -S --noconfirm --needed openssh libpam-google-authenticator qrencode

    if [ ! -f /etc/ssh/sshd_config.bkp ]; then
        cp  /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp
    fi
    cp ./arch/assets/etc_ssh_sshd_config /etc/ssh/sshd_config
    cp ./arch/assets/etc_pam.d_sshd /etc/pam.d/sshd

    systemctl enable sshd

    if [ ! -f /home/me/.google_authenticator ]; then
        totp_issuer=$(cat /etc/hostname)
        # TODO: rate-limit / rate-time
        # NOTE: -t time based, -D allow reuse, -u no-rate-limit
        su - me -c "google-authenticator -C -t -D -u --qr-mode=UTF8 --label=$totp_issuer --issuer=ssh"
        read -p "Press enter after you register the QR code... "
    fi
fi
