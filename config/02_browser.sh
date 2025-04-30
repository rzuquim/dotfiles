#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing browsers config${NC}"
echo "-----------------"

clone_or_update "$HOME/Config" git@github.com:rzuquim/librewolf.git

mkdir -p ~/.librewolf/default
mkdir -p ~/.librewolf/default/chrome/

function ensure_link() {
    local relative_path=$1
    if [ -e "$HOME/.librewolf/$relative_path" ]; then
        return
    fi

    echo -e "${VIOLET}Linking${NC} ~/.librewolf/$relative_path$"
    ln -s "$HOME/Config/librewolf/$relative_path" "$HOME/.librewolf/$relative_path"
}

if [ ! -L ~/.librewolf/profiles.ini ]; then
    echo -e "${RED}Deleting old ~/.librewolf config.${NC}"
    rm -rf ~/.librewolf/*
fi


# NOTE: using fd to ignore hidden files
fd . "$HOME/Config/librewolf/" --type f | while read -r config; do
    relative_path="${config#$HOME/Config/librewolf/}"
    ensure_link $relative_path
done

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
