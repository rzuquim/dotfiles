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

    read -p "Setup LLM server [Y/n] " response
    response=${response:-Y}
    if [[ $response =~ ^[Yy]$ ]]; then
        server_capabilities+=("llm")
    fi

    echo "${server_capabilities[@]}" > $SERVER_CAPABILITIES_FILE
fi

server_uid=$(id -u server)
server_gid=$(id -g server)

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
    media_server_group=media_server
    groupadd -f $media_server_group

    media_server_gid=$(getent group "$media_server_group" | cut -d: -f3)
    usermod -a -G $media_server_group me
    usermod -a -G $media_server_group server

    storage="/storage/media_server"
    mkdir -p "$storage"

    chown -R server:media_server $storage
    chmod -R 770 $storage

    export server_uid="$server_uid"
    export media_server_gid="$media_server_gid"
    export storage="$storage"
    envsubst < ./_assets/server/media-server.yml > /home/server/media_server.yml

    # NOTE: to install the jellyfin client on the samsung TV we used:
    # - https://github.com/Georift/install-jellyfin-tizen
fi

if [[ " ${server_capabilities[*]} " =~ " llm " ]]; then
    gpu_info=$(lspci | /bin/grep -Ei "VGA|3D")

    if echo "$gpu_info" | grep -iq "nvidia"; then
        llm_server_group=llm_server
        groupadd -f $llm_server_group

        llm_server_gid=$(getent group "$llm_server_group" | cut -d: -f3)
        usermod -a -G $llm_server_group me
        usermod -a -G $llm_server_group server

        storage="/storage/llm_server/"
        mkdir -p "$storage"

        chown -R server:llm_server $storage
        chmod -R 770 $storage

        export server_uid="$server_uid"
        export llm_server_gid="$llm_server_gid"
        export storage="$storage"
        envsubst < ./_assets/server/llm-server.yml > /home/server/llm_server.yml
    else
        echo -e "${RED}For now, this script only supports nvidia for LLM.${NC}"
        exit 1
    fi
fi

