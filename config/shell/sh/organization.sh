#!/bin/bash

function archive_file_name() {
    current_date=$(date +"%Y_%m_%d")
    filename=$(basename "$1")
    filename="${filename// /_}"

    # Remove diacritics using iconv
    filename=$(echo "$filename" | iconv -f utf8 -t ascii//TRANSLIT)

    new_filename="${current_date}_${filename}"
    mv "$1" "$(dirname "$1")/$new_filename"
}

