#!/bin/bash

echo -e "${CYAN}Ensuring user's home ownership${NC}"

for user in "${users[@]}"; do
    home_dir="/home/$user"
    chown -R "$user:$user" "$home_dir"
done

# NOTE: ensuring /home/.shared configs will be owned by "me" to make it easier to edit them
chown -R me:me /home/.shared
