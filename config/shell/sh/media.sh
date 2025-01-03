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

    output_file="${1%.md}.pdf"

    css_file="/tmp/rzuquim/github-markdown.min.css"
    cdn_url="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.8.1/github-markdown.min.css"

    if [ ! -f "$css_file" ]; then
        curl -sSL -o "$css_file" "$cdn_url"
        if [ $? -ne 0 ]; then
            echo "Error: Failed to download GitHub CSS file."
            return 1
        fi
    fi

    pandoc "$1" -o "$output_file" \
        --css="$css_file" \
        --highlight-style=pygments \
        --pdf-engine=wkhtmltopdf
}

