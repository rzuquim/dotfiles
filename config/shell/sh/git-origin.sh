#!/bin/sh

function git-origin() {
    ssh=`git remote get-url origin`
    remote=`echo $ssh | awk -F @ '{ print $2 }' | awk -F : '{ print $1 }'`
    repo=`echo $ssh | awk -F : '{ print $2 }'`
    repo=${repo%.*} # removing .git extension

    if [[ "$remote" == *"github"* ]]; then
        link="https://$remote/$repo/pulls"
    fi

    if [[ "$remote" == *"gitlab"* ]]; then
        branch=`git rev-parse --abbrev-ref HEAD`
        link="https://$remote/$repo/-/network/$branch"
    fi

    xdg-open $link
}

