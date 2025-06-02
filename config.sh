#!/bin/bash

set -euo pipefail

DOTFILES_REPO=git@github.com:rzuquim/dotfiles.git
DOTFILES_SHARED_LOCATION="/home/.shared/dotfiles"

if [ ! -d "$DOTFILES_SHARED_LOCATION" ]; then
    echo -e "Cloning dotfiles (using SSH)"
    git clone $DOTFILES_REPO $DOTFILES_SHARED_LOCATION
fi

USER_LIST_FILE="/etc/keys/users"

if [ ! -f $USER_LIST_FILE ]; then
    echo -e "${RED}Could not find user list file${NC} $USER_LIST_FILE"
    echo -e "Run setup.sh to write the file."
    exit 1
fi

users=($(cat $USER_LIST_FILE))
for user in "${users[@]}"; do
    target="/home/$user/Config/dotfiles"
    if ! sudo test -L "$target"; then
        echo "CREATING LINK $DOTFILES_SHARED_LOCATION -> $target"
        sudo ln -s "$DOTFILES_SHARED_LOCATION" "$target"
        sudo chown -h "$user:$user" "$target"
    fi
done

DOTFILES_LOCATION="/home/$(whoami)/Config/dotfiles"
cd "$DOTFILES_LOCATION"

for f in ./_utils/*.sh; do
    source "$f";
done

rz_banner

for f in ./config/*.sh; do
    source "$f";
done

