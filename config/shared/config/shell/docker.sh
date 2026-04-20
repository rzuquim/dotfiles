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

function docker_rm_stopped() {
    echo "Removing all stopped containers..."
    # The 'prune' command safely targets containers that are not running.
    # The '-f' flag forces the removal without asking for confirmation.
    docker container prune -f
    echo "Done."
}

function docker_rm_orphan_images() {
    echo "Removing all unused images..."
    # 'prune' removes unused images.
    # The '-a' flag ensures it removes ALL images not referenced by a container
    # (not just dangling/untagged "<none>" images).
    docker image prune -a -f
    echo "Done."
}

function docker_jump_in() {
    local container="$1"
    local cmd="${2:-/bin/bash}"

    # If no container is provided, use fzf to select one
    if [ -z "$container" ]; then
        if ! command -v fzf &> /dev/null; then
            echo "Error: 'fzf' is not installed."
            echo "Usage: docker_jump_in <container_name_or_id> [command]"
            return 1
        fi

        container=$(docker ps --format "{{.Names}}" | fzf --prompt="Select container to jump into: ")

        if [ -z "$container" ]; then
            echo "Operation cancelled."
            return 0
        fi
    fi

    echo "Jumping into '$container' using '$cmd'..."
    docker exec -it "$container" $cmd
}
