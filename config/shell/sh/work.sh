#!/bin/sh

function work() {
    local filter=$1
    echo -n 'work ' > ~/.ctx

    # navigating to work dir
    cd $(
        ~/.cargo/bin/fd \
            --type directory \
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

function work_on_tmux_session() {
    selected=$(\
            tmux ls 2>/dev/null | cut -d: -f1 | \
            { echo "--- NEW ---"; cat; } | \
        fzf)

    if [[ "$selected" == "--- NEW ---" ]]; then
        work
        echo -n "Enter new session name: "
        read session_name
        echo -e $session_name
        current_dir=$(basename "$(pwd)")
        final_name="[$current_dir] $session_name"
        final_name=echo $final_name | tr '.' '_'

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

