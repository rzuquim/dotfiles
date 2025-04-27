#!/bin/bash

set -euo pipefail

DOTFILES_REPO=git@github.com:rzuquim/dotfiles.git
DOTFILES_LOCATION="/home/me/Config/dotfiles"

if [ ! -d "$DOTFILES_LOCATION" ]; then
    echo -e "Cloning dotfiles (using SSH)"
    git clone $DOTFILES_REPO $DOTFILES_LOCATION
fi

cd "$DOTFILES_LOCATION"

for f in ./_utils/*.sh; do
    source "$f";
done

rz_banner

echo
echo "-----------------"
echo -e "${CYAN}Syncing configs${NC}"
echo "-----------------"

rsync -avh --no-perms ./config/shared/ /home/.shared

users=(me stream fun)

for user in "${users[@]}"; do
    if ! id $user &> /dev/null; then
        continue
    fi

    user_home="/home/$user"
    find /home/.shared -maxdepth 1 -type f | while read -r shared_config; do
        filename="$(basename "$shared_config")"
        # NOTE: adding leading . (to avoid versioning hidden files in this repo)
        target="$user_home/.$filename"

        if sudo test -L "$target"; then
            continue
        fi

        if sudo test ! -e "$user_home"; then
            sudo mkdir -p "$user_home"
        fi

        sudo ln -s "$shared_config" "$target"
        sudo chown -h "$user:$user" "$target"
        echo -e "${VIOLET}linking config file${NC} $shared_config ${VIOLET}into${NC} $target"
    done

    find /home/.shared/config -type f | while read -r shared_config; do
        rel_path="${shared_config#/home/.shared/config/}"
        target="$user_home/.config/$rel_path"
        target_dir="$(dirname "$target")"

        if sudo test -L "$target"; then
            continue
        fi

        if sudo test ! -e "$target_dir"; then
            sudo mkdir -p "$target_dir"
        fi

        sudo ln -s "$shared_config" "$target"
        sudo chown -h "$user:$user" "$target"
        echo -e "${VIOLET}linking config file${NC} $shared_config ${VIOLET}into${NC} $target"
    done
done

for user in "${users[@]}"; do
    if ! id $user &> /dev/null; then
        continue
    fi

    user_home="/home/$user"
    if sudo test ! -d "$user_home/.config"; then
        continue
    fi

    if [ ! -d "./config/$user/config" ]; then
        continue
    fi

    find ./config/$user/config -type f | while read -r user_config; do
        rel_path="${user_config#./config/$user/config/}"
        target="$user_home/.config/$rel_path"
        target_dir="$(dirname "$target")"

        if sudo test ! -e "$target_dir"; then
            sudo mkdir -p "$target_dir"
        fi

        abs_path_to_config=$(realpath "$user_config")
        echo -e "${VIOLET}copying custom config file${NC} $user_config ${VIOLET}into${NC} $target"
        sudo cp "$abs_path_to_config" "$target"
        sudo chown -h "$user:$user" "$target"
    done
done

echo
echo "-----------------"
echo -e "${CYAN}Syncing nvim config${NC}"
echo "-----------------"

if [ ! -L ~/.config/nvim ]; then
    if [ ! -d ~/Config/nvim ]; then
        echo -e "${CYAN}Cloning nvim config...${NC}"
        git clone git@github.com:rzuquim/nvim.git ~/Config/nvim
    fi

    echo "Linking ~/.config/nvim"
    ln -s ~/Config/nvim ~/.config/nvim
else
  pushd ~/Config/nvim/ &> /dev/null
  git pull
  popd &> /dev/null
fi

echo
echo "-----------------"
echo -e "${CYAN}Syncing browsers config${NC}"
echo "-----------------"

if [ ! -d ~/Config/librewolf ]; then
    echo -e "${CYAN}Cloning librewolf config...${NC}"
    git clone git@github.com:rzuquim/librewolf.git ~/Config/librewolf
else
    pushd ~/Config/librewolf &> /dev/null
    # TODO: git pull
    popd &> /dev/null
fi

mkdir -p ~/.librewolf/default

if [ -f ~/.librewolf/profiles.ini ]; then
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

if [ ! -L ~/.librewolf/default/addons.json ]; then
    echo "Linking ~/Config/librewolf/default/addons.json" 
    ln -s ~/Config/librewolf/default/addons.json ~/.librewolf/default/addons.json
fi



echo
echo "-----------------"
echo -e "${CYAN}Syncing wallpapers${NC}"
echo "-----------------"

if [ ! -d /home/.shared/wallpapers ]; then
    echo -e "${CYAN}Cloning wallpapers...${NC}"
    git clone https://github.com/rzuquim/wallpapers.git /home/.shared/wallpapers
else
  pushd /home/.shared/wallpapers &> /dev/null
  git pull
  popd &> /dev/null
fi

echo
echo "-----------------"
echo -e "${CYAN}Installing AUR stuff${NC} (cannot install as root on previous scripts)"
echo "-----------------"

YAY_PACKAGES=(
    "bluetuith"
    "librewolf-bin"
    "brave-bin"
    "whatsapp-for-linux"
    "telegram-desktop"
)

yay -S --needed ${YAY_PACKAGES[@]}
