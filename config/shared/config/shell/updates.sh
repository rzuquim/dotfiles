#!/bin/sh

# NOTE: those functions are using () to create subshells and isolate the sourced contexts

function sync_setup {
    pushd "$HOME/Config/dotfiles/" &> /dev/null
    (sudo bash "$HOME/Config/dotfiles/setup.sh")
    popd
}

function sync_config {
    pushd "$HOME/Config/dotfiles/" &> /dev/null
    (bash "$HOME/Config/dotfiles/config.sh")
    popd
}
