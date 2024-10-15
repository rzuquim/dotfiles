#!/bin/bash

# complete script on https://gitlab.com/dwt1/dotfiles/-/blob/master/.zshrc?ref_type=heads#L94
function inflate {
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: inflate <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       inflate <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        exit 1
    fi

    for n in "$@"
    do
        if [ ! -f "$n" ] ; then
            echo "'$n' - file does not exist"
            return 1
        fi

        # remove all extensions to get the folder name (for instance .tar.gz or tar.bz2)
        local folder_name="$n"
        while [[ "$folder_name" =~ \\. ]]; do
            folder_name="${folder_name%.*}"
            sleep 1
        done

        mkdir -p "$folder_name"

        case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                tar xvf "$n" -C "$folder_name" ;;
            *.cbr|*.rar)
                unrar x -ad "$n" "$folder_name" ;;
            *.gz)
                gunzip -c "$n" > "$folder_name/$(basename "$folder_name")" ;;
            *.cbz|*.epub|*.zip)
                unzip "$n" -d "$folder_name"       ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                7z x "$n" -o"$folder_name"        ;;
            *)
                echo "ex: '$n' - unknown archive method"
                return 1
                ;;
        esac
    done
}

