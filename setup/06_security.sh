#!/bin/bash

echo -e "${CYAN}Setting up security${NC}"

if [ ! -f /etc/nftables.conf.bkp ]; then
    echo -e "${YELLOW}Setting up firewall (nftables)${NC}"
    pacman -S --noconfirm --needed nftables
    systemctl enable nftables
    cp  /etc/nftables.conf /etc/nftables.conf.bkp
fi
cp ./_assets/etc/nftables.conf /etc/nftables.conf


if [ ! -f /etc/ssh/sshd_config.bkp ]; then
    echo -e "${YELLOW}Setting up SSH (using TOTP)${NC}"
    pacman -S --noconfirm --needed openssh libpam-google-authenticator qrencode
    cp  /etc/ssh/sshd_config /etc/ssh/sshd_config.bkp
fi

cp ./_assets/etc/ssh/sshd_config /etc/ssh/sshd_config
cp ./_assets/etc/pam.d/sshd /etc/pam.d/sshd

systemctl enable sshd

# TODO: TOTP
# NOTE: the only user that should be abble to ssh is the "me" user
# if [ ! -f /home/me/.google_authenticator ]; then
#     totp_issuer=$(cat /etc/hostname)
#     # TODO: rate-limit / rate-time
#     # NOTE: -t time based, -D allow reuse, -u no-rate-limit
#     su - me -c "google-authenticator -C -t -D -u --qr-mode=UTF8 --label=$totp_issuer --issuer=ssh"
#     read -p "Press enter after you register the QR code... "
# fi
