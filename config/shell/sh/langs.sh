#!/bin/sh

function node_setup_if_pertinent() {
    if command -v nvm &> /dev/null; then
        return
    fi

    found_files=$(
        ~/.cargo/bin/fd \
            --type file \
            -1 \
            --max-depth 4 \
            "${exclude_args[@]}" \
        "(package|tsconfig)\.json$" .)

    if [[ -n $found_files ]]; then
        export NVM_DIR=~/.nvm
        source "$NVM_DIR/nvm.sh"
    fi
}

function dotnet_setup_if_pertinent(){
    if [[ -v $DOTNET_SETUP ]]; then
        return
    fi

    found_files=$(
        ~/.cargo/bin/fd \
            --type file \
            -1 \
            --max-depth 3 \
            "${exclude_args[@]}" \
        "\.(sln|csproj)$" .)

    if [[ -z $found_files ]]; then
        return -1
    fi

    DOTNET_SETUP=0

    # dotnet completions
    _dotnet_zsh_complete()
    {
        local completions=("$(dotnet complete "$words")")

        # If the completion list is empty, just continue with filename selection
        if [ -z "$completions" ]
        then
            _arguments '*::arguments: _normal'
            return
        fi

        # This is not a variable assignment, don't remove spaces!
        _values = "${(ps:\n:)completions}"
    }
    compdef _dotnet_zsh_complete dotnet
}