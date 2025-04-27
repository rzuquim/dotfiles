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

for f in ./config/*.sh; do
    source "$f";
done

