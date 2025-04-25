#!/bin/sh

exclude_args_nav=()

function mkd {
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

function setup_nav() {
    local exclude_folders_nav=(
        .cache .asdf .local .cargo node_modules .git
        .config obj .zsh .nvm .vscode target .github
    )

    for folder in "${exclude_folders_nav[@]}"; do
        exclude_args_nav+=(--exclude "$folder")
    done
}

function fd_and_navigate() {
    local filter=$1

    local start_dir
    if git rev-parse --show-toplevel > /dev/null 2>&1; then
        start_dir=$(git rev-parse --show-toplevel)
    else
        start_dir=$(pwd)
    fi

    # navigating to work dir
    local selected=$(
        fd \
            --type directory \
            --unrestricted \
            --max-depth 10 \
            "${exclude_args_nav[@]}" \
            . "$start_dir" |
        fzf --ansi --query="$filter" --select-1
    )

    if [[ $? -ne 0 || -z $selected ]]; then
        return -1
    fi

    cd $selected
}

function back_to_folder() {
    local filter=$1

    local target_index=$(
        dirs -v |
        fzf --ansi --query="$filter" --select-1 |
        awk '{print $1}'  # Extract the index number
    )

    if [[ $? -ne 0 || -z $target_index ]]; then
        return -1
    fi

    for ((i = 0; i < target_index; i++)); do
        popd > /dev/null
    done
}

setup_nav
