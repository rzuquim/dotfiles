#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing nvim config${NC}"
echo "-----------------"

if [ ! -L ~/.config/nvim ]; then
    clone_or_update "$HOME/Config" git@github.com:rzuquim/nvim.git

    echo "Linking ~/.config/nvim"
    ln -s ~/Config/nvim ~/.config/nvim
else
    clone_or_update "$HOME/Config" git@github.com:rzuquim/nvim.git
fi
