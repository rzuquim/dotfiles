#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing wallpapers${NC}"
echo "-----------------"

if [ ! -d /home/.shared/wallpapers ]; then
    echo -e "${CYAN}Cloning wallpapers...${NC}"
    git clone https://github.com/rzuquim/wallpapers.git /home/.shared/wallpapers
else
  pushd /home/.shared/wallpapers &> /dev/null
  git pull
  popd &> /dev/null
fi

