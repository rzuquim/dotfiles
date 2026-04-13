#!/bin/bash

function pdf_pwd_rm() {
    # Check if correct number of arguments provided
    if [ "$#" -ne 2 ]; then
        echo "Usage: pdf_pwd_rm <input_file.pdf> <password>"
        return 1
    fi

    local input_file="$1"
    local password="$2"
    local output_file="${input_file%.pdf}_unlocked.pdf"

    # Verify input file existence
    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found."
        return 1
    fi

    qpdf --decrypt --password="$password" "$input_file" "$output_file"

    if [ $? -eq 0 ]; then
        echo "Success: Unlocked PDF created at '$output_file'"
    else
        echo "Error: Failed to decrypt PDF. Check your password."
        return 1
    fi
}
