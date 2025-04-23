#!/bin/bash

echo -e "${CYAN}Setting up basic hosts${NC}"

if [ ! -f "/etc/hostname" ]; then
    echo -e "${YELLOW}Setting hostname${NC}"
    echo "$hostname" > /etc/hostname
    export hostname="$hostname"
    # NOTE: assuming this is running from git folder
    envsubst < ./_assets/etc/hosts.template > /etc/hosts
fi
