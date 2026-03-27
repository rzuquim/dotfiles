#!/bin/sh

function md_to_pdf() {
    if [ -z "$1" ]; then
        echo "Error: provide a md file"
        return 1
    fi

    if [[ "$1" != *.md ]]; then
        echo "Error: the file must have a .md extension."
        return 1
    fi

    if [[ "$2" == "accessible" ]]; then
        css_file="$HOME/.config/shell/assets/md-to-pdf-acessible.css"
    else
        css_file="$HOME/.config/shell/assets/md-to-pdf.css"
    fi

    if [[ "$3" == "debug" ]]; then
        local output_file="${1%.md}.html"
        pandoc "$1" -o "$output_file" \
            --css="$css_file" \
            --highlight-style=pygments
    else
        local output_file="${1%.md}.pdf"
        pandoc "$1" -o "$output_file" \
            --css="$css_file" \
            --highlight-style=pygments \
            --pdf-engine=weasyprint
    fi

}

resize_w() {
    local input="$1"
    local width="$2"

    if [ -z "$input" ] || [ -z "$width" ]; then
        echo "ERROR! Usage: resize_w <input> <width>"
        return 1
    fi

    local output="${input%.*}-w${width}.png"

    ffmpeg -i "$input" -vf "scale=${width}:-1" "$output"
}

resize_h() {
    local input="$1"
    local height="$2"

    if [ -z "$input" ] || [ -z "$height" ]; then
        echo "ERROR! Usage: resize_h <input> <height>"
        return 1
    fi

    local output="${input%.*}-h${height}.png"

    ffmpeg -i "$input" -vf "scale=-1:${height}" "$output"
}
