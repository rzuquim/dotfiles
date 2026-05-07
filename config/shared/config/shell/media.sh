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

png_to_web() {
    local input="$1"
    local keep_alpha="${2:-false}"
    local quality="${3:-high}"

    if [[ -z "$input" ]]; then
        echo "usage: img_to_web <file.png> [keep_alpha=false] [quality=high|medium|low]"
        return 1
    fi

    if [[ ! -f "$input" ]]; then
        echo "file not found: $input"
        return 1
    fi

    local filename
    filename="$(basename -- "$input")"

    local name="${filename%.*}"

    local webp_output="${name}.webp"
    local avif_output="${name}.avif"
    local jpeg_output="${name}.jpg"

    local pix_fmt="yuv420p"

    if [[ "$keep_alpha" == "true" ]]; then
        pix_fmt="yuva420p"
    fi

    local webp_q
    local avif_crf
    local jpeg_q

    case "$quality" in
        high)
            webp_q=90
            avif_crf=20
            jpeg_q=2
            ;;
        medium)
            webp_q=75
            avif_crf=35
            jpeg_q=5
            ;;
        low)
            webp_q=55
            avif_crf=45
            jpeg_q=10
            ;;
        *)
            echo "invalid quality: $quality"
            echo "valid values: high, medium, low"
            return 1
            ;;
    esac

    echo "Generating WebP..."
    ffmpeg -y -i "$input" \
        -pix_fmt "$pix_fmt" \
        -q:v "$webp_q" \
        -compression_level 6 \
        "$webp_output"

    echo "Generating AVIF..."
    ffmpeg -y -i "$input" \
        -pix_fmt "$pix_fmt" \
        -crf "$avif_crf" \
        "$avif_output"

    echo "Generating JPEG..."
    ffmpeg -y -i "$input" \
        -pix_fmt yuvj420p \
        -q:v "$jpeg_q" \
        "$jpeg_output"

    echo "Done:"
    echo " - $webp_output"
    echo " - $avif_output"
    echo " - $jpeg_output"
}
