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
