#!/usr/bin/env bash

git-change-ssh-key() {
    local pvt_key="$HOME/.ssh/id_ed25519"
    local pub_key="$pvt_key.pub"

    if [ -z "$1" ]; then
        echo "Error: provide a key suffix"
        return 1
    fi

    # check if private/public keys are not links
    if [ -f "$pvt_key" ] && [ ! -L "$pvt_key" ]; then
        echo "Private key is not a link!"
        return 1
    fi

    if [ -f "$pub_key" ] && [ ! -L "$pub_key" ]; then
        echo "Public key is not a link!"
        return 1
    fi

    # remove existing private/public keys if they exist
    if [ -f "$pvt_key" ]; then
        rm "$pvt_key"
    fi

    if [ -f "$pub_key" ]; then
        rm "$pub_key"
    fi

    # create symlinks to the desired secrets
    ln -s "$HOME/.ssh/$1/id_ed25519" "$pvt_key"
    ln -s "$HOME/.ssh/$1/id_ed25519.pub" "$pub_key"
}

git-ssh-key-toggle() {
    curr=$(/bin/ls -l ~/.ssh/id_ed25519 | awk '{print $NF}' | awk -F'/' '{print $(NF-1)}' )
    opts=$(/bin/ls -d ~/.ssh/*/ | xargs -n 1 basename)

    # erases the current option from opts
    opts=("${opts[@]/$curr/}")

    # removes the empty entry after erasing
    opts=($(echo "${opts[@]}" | awk 'NF'))

    case "${#opts[@]}" in
        0)
            echo "No available shh keys"
            ;;
        1)
            selected="${opts[1]}"
            git-change-ssh-key "$selected"
            ;;
        *)
            selected=$(printf "%s\n" "${directories[@]}" | fzf)
            git-change-ssh-key "$selected"
            ;;
    esac
}
