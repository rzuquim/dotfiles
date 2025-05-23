#!/bin/bash

if ! id "server" &>/dev/null; then
    echo -e "${YELLOW}Not installing server stuff.${NC}"
    return
fi

echo -e "${CYAN}Setting up server.${NC}"

SERVER_CAPABILITIES_FILE=/etc/keys/server_capabilities

if [ -f $SERVER_CAPABILITIES_FILE ]; then
    echo -e "${YELLOW}Loading server capabilities from${NC} $SERVER_CAPABILITIES_FILE"
    echo -e "${VIOLET}Delete it if you want to change it.${NC}"
    server_capabilities=($(cat $SERVER_CAPABILITIES_FILE))
else
    server_capabilities=()

    read -p "Setup DNS server [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Yy]$ ]]; then
        server_capabilities+=("dns")
    fi

    read -p "Setup media server [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Yy]$ ]]; then
        server_capabilities+=("media")
    fi

    echo "${server_capabilities[@]}" > $SERVER_CAPABILITIES_FILE
fi

if [[ " ${server_capabilities[*]} " =~ " dns " ]]; then
    echo -e "${RED}DNS Server is too much work to setup and maintain, using hosts file directly.${NC}"
    exit 1
    # echo -e "${CYAN}Setting up DNS Server${NC}"
    # pacman -S --noconfirm --needed dnsmasq
    #
    # cp ./_assets/etc/dns/dnsmasq.conf /etc/dnsmasq.conf
    # cp ./_assets/etc/dns/dnsmasq.hosts /etc/dnsmasq.hosts
    # cp ./_assets/etc/dns/nsswitch.conf /etc/nsswitch.conf
    #
    # systemctl enable --now dnsmasq
fi

if [[ " ${server_capabilities[*]} " =~ " media " ]]; then
    pacman -S qbittorrent-nox

    mkdir -p /var/lib/qbittorrent/.config/qBittorrent
    cp ./_assets/server/torrent/qBittorrent.conf /var/lib/qbittorrent/.config/qBittorrent/qBittorrent.conf

    TORRENT_FIREWALL_RULES=$(cat <<EOF
        # Allow qBittorrent Web UI
        tcp dport 1337 accept

        # Allow incoming BitTorrent traffic
        udp dport 8999 accept
EOF
    )

    nft_rule_add "@torrent" $TORRENT_FIREWALL_RULES

    systemctl enable --now qbittorrent-nox.service
fi

# NOTE: reloading firewall rules
nft -f /etc/nftables.conf
