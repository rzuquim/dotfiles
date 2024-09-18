#!/bin/bash

if [ -z "$MY_NAME" ] || [ -z "$MY_EMAIL" ]; then
    WHOAMI_FILE=~/.rzuquim/whoami
    if [ ! -f "$WHOAMI_FILE" ]; then
        echo "Could not find out who you are! Please run the boostrap script!"
        exit 1
    else
        MY_EMAIL=$(head -n 1 $WHOAMI_FILE)
        MY_NAME=$(tail -n 1 $WHOAMI_FILE)
        echo "Welcome back $MY_NAME ($MY_EMAIL)!"
    fi
fi

