#!/bin/sh

function wipe_nvim() {
    rm -rf ~/.local/share/nvim
    rm -rf ~/.cache/nvim
    rm -rf ~/.local/state/nvim
}

