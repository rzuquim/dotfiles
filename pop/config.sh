#!/bin/bash

source "./pop/config_setup.sh"

echo "${RED}This will overwrite existing files in your home directory.${NC}"
echo

echo -e "${VIOLET}*Configuration${NC}"
echo
read -p "Apply default config? [Y/n] " response
response=${response:-Y}
if [[ $response =~ ^[Yy]$ ]]; then
    rsync \
        --exclude ".git/" \
        --exclude ".DS_Store" \
        --ignore-existing \
        -avh --no-perms ./config/ $HOME/.config > /dev/null

    set_default_terminal "$HOME/.cargo/bin/alacritty"
    set_default_shell "/usr/bin/zsh"
else
    echo -e "${RED}Won't apply shell configuration!${NC}"
fi