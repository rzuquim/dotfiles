#!/bin/bash

if [ -z "$MY_NAME" ] || [ -z "$MY_EMAIL" ]; then
    WHOAMI_FILE=$WORKSPACE/whoami

    if [ ! -f "$WHOAMI_FILE" ]; then
        MY_EMAIL=rzuquim@gmail.com
        MY_NAME="Rafael Zuquim"

        read -p "Are you me? [Y/n] " response

        response=${response:-Y}
        if [[ $response =~ ^[Nn]$ ]]; then
            echo -e "${CYAN}Setting up main user${NC}"

            read -p "Please enter your email: " MY_EMAIL
            read -p "Please enter your first and last names: " MY_NAME
        fi

        echo "$MY_EMAIL" > $WHOAMI_FILE
        echo "$MY_NAME" >> $WHOAMI_FILE
    else
        MY_EMAIL=$(head -n 1 $WHOAMI_FILE)
        MY_NAME=$(tail -n 1 $WHOAMI_FILE)
        echo -e "${CYAN}Welcome back${NC} ${MY_NAME} (${MY_EMAIL})"
    fi

    echo
fi

