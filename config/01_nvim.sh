#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing nvim config${NC}"
echo "-----------------"

if [ ! -L ~/.config/nvim ]; then
    if [ ! -d ~/Config/nvim ]; then
        echo -e "${CYAN}Cloning nvim config...${NC}"
        git clone git@github.com:rzuquim/nvim.git ~/Config/nvim
    fi

    echo "Linking ~/.config/nvim"
    ln -s ~/Config/nvim ~/.config/nvim
else
  pushd ~/Config/nvim/ &> /dev/null
  git pull
  popd &> /dev/null
fi
