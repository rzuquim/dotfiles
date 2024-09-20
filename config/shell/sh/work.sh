#!/bin/sh

function work() {
    local filter=$1
    echo -n 'work ' > ~/.ctx

    # navigating to work dir
    cd $(
        fd --type directory \
            --unrestricted \
            --max-depth 5 \
            --exclude .cache --exclude .asdf --exclude .local --exclude .cargo --exclude node-modules \
            --exclude .config --exclude bin --exclude obj --exclude .zsh --exclude .nvm \
            --prune ^.git$ $HOME |
        awk 'BEGIN {COLOR="\033[32m"; RESET="\033[0m";} NF{NF-=2} { print COLOR "[" $NF "] " RESET $0 }' \
            FS='/' OFS='/' |
        fzf --ansi --query="$filter" --select-1 |
        awk '{ print $2 }'
    )

    # adding work folder on context
    pwd | xargs echo -n >> ~/.ctx
}

function work_and_editor() {
    work $1

    # ------------------------------
    # dotnet
    # ------------------------------
    sln_files_search=$(fd --max-depth 1 --extension sln)
    sln_files=($sln_files_search)

    if [ ${#sln_files[@]} -eq 1 ]; then
        rider "./$sln_files" > /dev/null 2>&1 &
        return
    fi

    # ------------------------------
    # else
    # ------------------------------
    nvim .
}
