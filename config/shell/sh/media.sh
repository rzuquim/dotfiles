#!/bin/sh

function md-to-pdf() {
    if [ -z "$1" ]; then
        echo "Error: provide a md file"
        return 1

    fi

    if [[ "$1" != *.md ]]; then
        echo "Error: the file must have a .md extension."
        return 1
    fi

    output_file="${1%.md}.pdf"

    pandoc $1 -f gfm --pdf-engine=xelatex --highlight-style kate -o $output_file
}

