#!/bin/bash

function docker_interactive() {
    local filter="$1"
    local shell="${2:-/bin/bash}"

    local image
    if [[ -z "$filter" ]]; then
        image=$(docker images --format '{{.Repository}}:{{.Tag}}' | fzf --ansi --query="$filter" --select-1)
    else
        image=$filter
    fi

    if [[ -z "$image" ]]; then
        echo "No image selected. Exiting."
        return 1
    fi

    docker container run --rm -it "$image" "$shell"
}
