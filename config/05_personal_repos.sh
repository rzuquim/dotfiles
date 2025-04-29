#!/bin/bash

GIT_WHO_AM_I="/home/me/.config/git/whoami.toml"
MY_EMAIL=$(sed -n '2p' $GIT_WHO_AM_I)

echo "checking $MY_EMAIL"

if [[ "$MY_EMAIL" != *"rzuquim@gmail.com" ]]; then
    return
fi

echo
echo "-----------------"
echo -e "${CYAN}Ensuring personal github projects are up to date${NC}"
echo "-----------------"

if [ ! -d "/home/me/Personal" ]; then
    mkdir /home/me/Personal
fi

personal_folder="/home/me/Personal"
personal_repos=(
    "git@github.com:rzuquim/diario.git"
    "git@github.com:rzuquim/notes.git"
    "git@github.com:rzuquim/blog.git"
)

for repo in "${personal_repos[@]}"; do
    clone_or_update $personal_folder $repo
done

edu_folder="/home/me/Education"
edu_repos=(
    "git@github.com:rzuquim/edu-creative.git"
    "git@github.com:rzuquim/edu-espanol.git"
    "git@github.com:rzuquim/edu-books.git"
    "git@github.com:rzuquim/aoc.git"
)

for repo in "${edu_repos[@]}"; do
    clone_or_update $edu_folder $repo
done
