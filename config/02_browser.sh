#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing browsers config${NC}"
echo "-----------------"

clone_or_update "$HOME/Config" git@github.com:rzuquim/librewolf.git

mkdir -p ~/.librewolf/default

if [ ! -L ~/.librewolf/profiles.ini ]; then
    echo -e "${RED}Deleting old ~/.librewolf config.${NC}"
    rm -rf ~/.librewolf/*
fi

mkdir -p ~/.librewolf/default
if [ ! -e ~/.librewolf/profiles.ini ]; then
    echo "Linking ~/.librewolf/profiles.ini"
    ln -s ~/Config/librewolf/profiles.ini ~/.librewolf/profiles.ini
fi

if [ ! -L ~/.librewolf/default/user.js ]; then
    echo "Linking ~/Config/librewolf/default/user.js" 
    ln -s ~/Config/librewolf/default/user.js ~/.librewolf/default/user.js
fi

# TODO: permissions white list
# if [ ! -L ~/.librewolf/default/permissions.sqlite ]; then
#     echo "Linking ~/Config/librewolf/default/permissions.sqlite" 
#     ln -s ~/Config/librewolf/default/permissions.sqlite ~/.librewolf/default/permissions.sqlite
# fi

# TODO: install extensions
# if [ ! -L ~/.librewolf/default/addons.json ]; then
#     echo "Linking ~/Config/librewolf/default/addons.json" 
#     ln -s ~/Config/librewolf/default/addons.json ~/.librewolf/default/addons.json
# fi
#
# EXTENSIONS_DIR="$HOME/.librewolf/default/extensions"
# if [ ! -e "$EXTENSIONS_DIR" ]; then
#     mkdir -p "$EXTENSIONS_DIR"
#
#     echo "${CYAN}Downloading and installing extensions...${NC}"
#     declare -A EXTENSIONS=(
#         ["addon@darkreader.org"]="https://addons.mozilla.org/firefox/downloads/file/4229264/darkreader-4.9.76.xpi"
#         ["addon@vimium"]="https://addons.mozilla.org/firefox/downloads/file/4458679/vimium_ff-2.2.1.xpi"
#     )
#
#     for addon_id in "${!EXTENSIONS[@]}"; do
#         echo "Installing $addon_id..."
#         wget -O "$EXTENSIONS_DIR/$addon_id.xpi" "${EXTENSIONS[$addon_id]}"
#
#         if [ $? -eq 0 ]; then
#             echo "Successfully installed $addon_id"
#         else
#             echo "Failed to install $addon_id"
#         fi
#     done
# fi
