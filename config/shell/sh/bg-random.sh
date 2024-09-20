#!/bin/sh

function bg-random() {
    BG_DIR=$HOME/.config/wallpapers

    # Feeding random generator with the date in seconds (UNIX time)
    RANDOM=$$$(date +%s)
    BG_LIST=("${BG_DIR}"/*.jpg)
    BG_NUM=$(ls -1 "${BG_DIR}" | wc -l)
    SELECTED_BG=$(( $RANDOM % ${BG_NUM} ))
    BG_RANDOM_URL="file://${BG_LIST[$SELECTED_BG]}"

    gsettings set org.gnome.desktop.background picture-uri $BG_RANDOM_URL
    gsettings set org.gnome.desktop.background picture-uri-dark $BG_RANDOM_URL
    gsettings set org.gnome.desktop.background picture-options "stretched"
}

