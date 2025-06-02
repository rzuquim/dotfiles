#!/bin/bash

GIT_WHO_AM_I="/home/me/.config/git/whoami.toml"
MY_EMAIL=$(sed -n '2p' $GIT_WHO_AM_I)

if [[ "$MY_EMAIL" != *"rzuquim@gmail.com" ]]; then
    return
fi

echo
echo "-----------------"
echo -e "${CYAN}Ensuring github projects are up to date${NC}"
echo "-----------------"


if [ "$(whoami)" = "me" ]; then
    edu_folder="/home/me/Education"
    edu_repos=(
        "git@github.com:rzuquim/edu-creative.git"
        "git@github.com:rzuquim/edu-books.git"
        "git@github.com:rzuquim/aoc.git"
    )

    for repo in "${edu_repos[@]}"; do
        clone_or_update $edu_folder $repo
    done

    personal_folder="/home/me/Personal"
    personal_repos=(
        "git@github.com:rzuquim/notes.git"
    )

    for repo in "${personal_repos[@]}"; do
        clone_or_update $personal_folder $repo "write"
    done
fi

# NOTE: Writing repos on user "write"
if [ "$(whoami)" = "write" ]; then
    personal_folder="/home/write/Personal"
    personal_repos=(
        "git@github.com:rzuquim/diario.git"
        "git@github.com:rzuquim/blog.git"
        "git@github.com:rzuquim/cocina.git"
        "git@github.com:rzuquim/notes.git"
    )

    for repo in "${personal_repos[@]}"; do
        clone_or_update $personal_folder $repo "write"
    done

    edu_folder="/home/write/Education"
    edu_repos=(
        "git@github.com:rzuquim/edu-creative.git"
        "git@github.com:rzuquim/edu-espanol.git"
    )

    for repo in "${edu_repos[@]}"; do
        clone_or_update $edu_folder $repo
    done
fi

