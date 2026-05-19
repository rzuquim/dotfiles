#!/bin/bash

font_install() {
    local FONT_SRC="$1"
    local FONT_DIR="$HOME/.local/share/fonts"

    if [[ -z "$FONT_SRC" ]]; then
        echo "Usage: font_install <font-file-or-directory>"
        return 1
    fi

    mkdir -p "$FONT_DIR"

    if [[ -d "$FONT_SRC" ]]; then
        echo "Copying font directory..."
        cp -r "$FONT_SRC"/* "$FONT_DIR/"
    elif [[ -f "$FONT_SRC" ]]; then
        echo "Copying font file..."
        cp "$FONT_SRC" "$FONT_DIR/"
    else
        echo "Invalid path: $FONT_SRC"
        return 1
    fi

    chmod -R 644 "$FONT_DIR"/* 2>/dev/null || true

    echo "Rebuilding font cache..."
    fc-cache -fv

    echo "Done."
}

font_gimp() {
    local FONT_NAME="$1"
    local USER_FONT_DIR="$HOME/.local/share/fonts"
    local SYSTEM_FONT_DIR="/usr/share/fonts"
    local GIMP_FONT_DIR="$HOME/.config/gimp/fonts"

    if [[ -z "$FONT_NAME" ]]; then
        echo "Searching for '$FONT_NAME'..."
    fi

    mkdir -p "$GIMP_FONT_DIR"


    local FONT_PATH=$(find "$USER_FONT_DIR" -name "*$FONT_NAME*" -type f 2>/dev/null | head -n 1)

    if [[ -z "$FONT_PATH" ]]; then
        echo "Not found in user directory. Checking system shared fonts..."
        FONT_PATH=$(find "$SYSTEM_FONT_DIR" -name "*$FONT_NAME*" -type f 2>/dev/null | head -n 1)
    fi

    if [[ -z "$FONT_PATH" ]]; then
        echo "Error: Could not find font matching '$FONT_NAME' in user or system paths."
        return 1
    fi

    local FILENAME=$(basename "$FONT_PATH")

    if [[ -L "$GIMP_FONT_DIR/$FILENAME" ]]; then
        echo "Symlink already exists for $FILENAME"
    else
        ln -s "$FONT_PATH" "$GIMP_FONT_DIR/$FILENAME"
        echo "Success! Linked: $FILENAME"
        echo "Source: $FONT_PATH"
    fi
}
