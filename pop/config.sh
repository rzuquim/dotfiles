#!/bin/bash

source "./pop/config_setup.sh"

echo -e "${RED}This will overwrite existing files in your home directory.${NC}"
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
    set_default_profile
    set_git_config
    set_nvim_config
    source "./pop/gnome_bind_keymaps.sh"
    source "./pop/gnome_config.sh"
else
    echo -e "${RED}Won't apply shell configuration!${NC}"
fi

echo
echo -e "${VIOLET}* Appearance${NC}"
echo
read -p "Apply default appearance? [Y/n] " response
response=${response:-Y}
if [[ $response =~ ^[Yy]$ ]]; then
    rsync \
        --exclude ".git/" \
        --exclude ".DS_Store" \
        --ignore-existing \
        -avh --no-perms ./gnome/ $HOME/.local > /dev/null

    setup_dock
    set_shortcuts
    setup_startup_apps
    # TODO: remove animations
else
    echo -e "${RED}Won't apply appearance configuration!${NC}"
fi
