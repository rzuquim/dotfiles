#!/bin/bash

echo -e "${CYAN}Ensuring user's home ownership${NC}"

for user in "${users[@]}"; do
    home_dir="/home/$user"
    chown -R "$user:$user" "$home_dir"
done
