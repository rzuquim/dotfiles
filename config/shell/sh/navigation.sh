#!/bin/sh

function fd_and_navigate() {
    local filter=$1

    local start_dir
    if git rev-parse --show-toplevel > /dev/null 2>&1; then
        start_dir=$(git rev-parse --show-toplevel)
    else
        start_dir=$(pwd)
    fi

    # navigating to work dir
    cd $(
        ~/.cargo/bin/fd \
            --type directory \
            --unrestricted \
            --max-depth 10 \
            --exclude .cache --exclude .asdf --exclude .local --exclude .cargo --exclude node-modules \
            --exclude .config --exclude bin --exclude obj --exclude .zsh --exclude .nvm --exclude .git \
            . "$start_dir" |
        fzf --ansi --query="$filter" --select-1
    )
}

