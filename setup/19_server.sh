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

    read -p "AI server [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Yy]$ ]]; then
        server_capabilities+=("ai")
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
    pacman -S --noconfirm --needed qbittorrent-nox

    echo "criando pasta"
    mkdir -p /var/lib/qbittorrent/.config/qBittorrent
    cp ./_assets/server/torrent/qBittorrent.conf /var/lib/qbittorrent/.config/qBittorrent/qBittorrent.conf

    nft_rule_add "@torrent" $(realpath "./_assets/server/torrent/firewall_rules.conf")

    systemctl enable --now qbittorrent-nox.service
fi

if [[ " ${server_capabilities[*]} " =~ " ai " ]]; then
    gpu_info=$(lspci | /bin/grep -Ei "VGA|3D")

    if echo "$gpu_info" | grep -iq "nvidia"; then
        pacman -S --noconfirm --needed ollama-cuda
    else
        echo -e "${RED}For now, this script only supports nvidia for AI.${NC}"
        exit 1
    fi
fi

# NOTE: reloading firewall rules
nft -f /etc/nftables.conf
