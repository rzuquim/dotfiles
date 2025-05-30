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

    output_file="${1%.md}.pdf"

    pandoc "$1" -o "$output_file" \
        --css="$css_file" \
        --highlight-style=pygments \
        --pdf-engine=weasyprint
}

