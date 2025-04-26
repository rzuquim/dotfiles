#!/bin/sh

# NOTE: those functions are using () to create subshells and isolate the sourced contexts

function sync_setup {
    pushd "$HOME/dotfiles/" &> /dev/null
    (sudo bash "$HOME/dotfiles/setup.sh")
    popd
}

function sync_config {
    pushd "$HOME/dotfiles/" &> /dev/null
    (bash "$HOME/dotfiles/config.sh")
    popd
}
