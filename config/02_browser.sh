#!/bin/bash

echo
echo "-----------------"
echo -e "${CYAN}Syncing browsers config${NC}"
echo "-----------------"

if [ ! -d ~/Config/librewolf ]; then
    echo -e "${CYAN}Cloning librewolf config...${NC}"
    git clone git@github.com:rzuquim/librewolf.git ~/Config/librewolf
else
    pushd ~/Config/librewolf &> /dev/null
    git pull
    popd &> /dev/null
fi

mkdir -p ~/.librewolf/default

if [ -f ~/.librewolf/profiles.ini ]; then
    echo -e "${RED}Deleting old ~/.librewolf config.${NC}"
    rm -rf ~/.librewolf/*
fi

mkdir -p ~/.librewolf/default
if [ ! -e ~/.librewolf/profiles.ini ]; then
    echo "Linking ~/.librewolf/profiles.ini"
    ln -s ~/Config/librewolf/profiles.ini ~/.librewolf/profiles.ini
fi

if [ ! -L ~/.librewolf/default/user.js ]; then
    echo "Linking ~/Config/librewolf/default/user.js" 
    ln -s ~/Config/librewolf/default/user.js ~/.librewolf/default/user.js
fi

if [ ! -L ~/.librewolf/default/addons.json ]; then
    echo "Linking ~/Config/librewolf/default/addons.json" 
    ln -s ~/Config/librewolf/default/addons.json ~/.librewolf/default/addons.json
fi
