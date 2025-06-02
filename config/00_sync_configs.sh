#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing configs${NC}"
echo "-----------------"

rsync -avh --no-perms ./config/shared/ /home/.shared

for user in "${users[@]}"; do
    if ! id $user &> /dev/null; then
        continue
    fi

    user_home="/home/$user"
    # HACK: wasistlos keeps creating this file ~/.config/wasistlos/settings.conf instead of preserving our link
    if [ -f "$user_home/.config/wasistlos/settings.conf" ]; then
        sudo rm -rf "$user_home/.config/wasistlos"
    fi

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

# NOTE: ensuring correct monitors configuration after syncing configs
bash ~/.config/hypr/scripts/monitors_and_workspaces.sh

