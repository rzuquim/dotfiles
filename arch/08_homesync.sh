#!/bin/bash

if [[ -n "$ARCH_INTERACTIVE" ]]; then
    read -p "Sync home configs? [y/N] " response

    response=${response:-N}
    if [[ $response =~ ^[Nn]$ ]]; then
        ARCH_NO_SYNC_HOME_CONFIG=true
    fi
fi

if [[ -z "$ARCH_NO_SYNC_HOME_CONFIG" ]]; then
    echo -e "${CYAN}Configuring .configs:${NC} shared"
    rsync -avh --no-perms ./arch/home/shared/ /home/.shared

    find /home/.shared -type f -exec chmod 644 {} \;
    find /home/.shared -type d -exec chmod 755 {} \;
    chown -R root:root /home/.shared

    users=(me stream fun)

    for user in "${users[@]}"; do
        user_home="/home/$user"

        find /home/.shared -maxdepth 1 -type f | while read -r shared_config; do
            echo "starting $shared_config"

            filename="$(basename "$shared_config")"
            # NOTE: adding leading . (to avoid versioning hidden files in this repo)
            target="$user_home/.$filename"

            echo "checking link $target for $shared_config"
            [ -L "$target" ] && continue

            if [ ! -e "$user_home" ]; then
                mkdir -p "$user_home"
            fi

            if [ ! -e "$target" ]; then
                mv "$target" "$target.bak"
            fi

            ln -s "$shared_config" "$target"
            chown -h "$user:$user" "$target"
            echo -e "${VIOLET}linking config file${NC} $shared_config ${VIOLET}into${NC} $target"
        done

        find /home/.shared/config -type f | while read -r shared_config; do
            rel_path="${shared_config#/home/.shared/config/}"
            target="$user_home/.config/$rel_path"
            target_dir="$(dirname "$target")"

            [ -L "$target" ] && continue

            if [ ! -e "$target_dir" ]; then
                mkdir -p "$target_dir"
            fi

            if [ ! -e "$target" ]; then
                mv "$target" "$target.bak"
            fi

            ln -s "$shared_config" "$target"
            chown -h "$user:$user" "$target"
            echo -e "${VIOLET}linking config file${NC} $shared_config ${VIOLET}into${NC} $target"
        done
    done
fi
