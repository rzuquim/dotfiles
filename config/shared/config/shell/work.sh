#!/bin/sh

if [[ -f "$HOME/.ctx" ]]; then
    local current_workspace=`cat ~/.ctx | awk '{ print $2 }'`
    cd $current_workspace
fi

exclude_args_work=()

function setup_work() {
    local exclude_folders=(
        .cache .asdf .local .cargo node_modules
        .config bin obj .zsh .nvm .vscode target .github
    )

    for folder in "${exclude_folders[@]}"; do
        exclude_args_work+=(--exclude "$folder")
    done
}

function work() {
    local filter=$1
    echo -n 'work ' > ~/.ctx

    # navigating to work dir
    local selected=$(
        fd \
            --type directory \
            --unrestricted \
            --max-depth 5 \
            "${exclude_args_work[@]}" \
            --prune ^.git$ $HOME |
        awk 'BEGIN {COLOR="\033[32m"; RESET="\033[0m";} NF{NF-=2} { print COLOR "[" $NF "] " RESET $0 }' \
            FS='/' OFS='/' |
        fzf --ansi --query="$filter" --select-1 |
        awk '{ print $2 }'
    )

    if [[ $? -ne 0 || -z $selected ]]; then
        return -1
    fi

    cd $selected

    node_setup_if_pertinent
    dotnet_setup_if_pertinent

    # adding work folder on context
    pwd | xargs echo -n >> ~/.ctx
    return 0
}

function work_and_editor() {
    work $1

    if [[ $? -ne 0 ]]; then
        return -1
    fi

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

function work_on_tmux_session() {
    local selected=$(\
            tmux ls 2>/dev/null | cut -d: -f1 | \
            { echo "--- NEW ---"; cat; } | \
        fzf)

    if [[ $? -ne 0 || -z $selected ]]; then
        return -1
    fi

    if [[ "$selected" == "--- NEW ---" ]]; then
        work

        if [[ -z $selected ]]; then
            return -1
        fi
        echo -n "Enter new session name: "
        read session_name
        echo -e $session_name
        current_dir=$(basename "$(pwd)")
        final_name="[$current_dir] $session_name"
        final_name=$(echo $final_name | tr '.' '_')

        # editor window
        tmux new-session -s "$final_name" -d
        tmux rename-window -t "$final_name:1" "editor"
        tmux send-keys -t "$final_name:1" "nvim" C-m

        # jobs window
        tmux new-window -t "$final_name:2" -n "jobs"
        tmux split-window -h -t "$final_name:2"
        # TODO: auto-discover: run and tests
        tmux send-keys -t "$final_name:2.0" "watch_run" C-m
        tmux send-keys -t "$final_name:2.1" "watch_tests" C-m

        # git window
        tmux new-window -t "$final_name:3" -n "gitui"
        tmux send-keys -t "$final_name:3" "gitui" C-m

        # Attach to the session
        tmux attach-session -t "$final_name:1"
    else
        tmux attach-session -t "$selected"
    fi
}

function config {
    local config_dir="$HOME/.config"
    local selected=$(/bin/ls "$config_dir" | fzf)

    if [[ $? -ne 0 || -z "$selected" ]]; then
        echo "Selection canceled or invalid."
        return 1
    fi

    local full_path="$config_dir/$selected"

    if [[ -d "$full_path" ]]; then
        cd "$full_path" || return 1
        nvim .
    else
        cd "$config_dir" || return 1
        nvim "$full_path"
    fi
}

setup_work
