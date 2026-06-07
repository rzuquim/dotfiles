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


function md_to_pdf_custom() {
    if [ -z "$1" ]; then
        echo "Error: provide a md file"
        return 1
    fi

    if [ -z "$2" ]; then
        echo "Error: provide a css file"
        return 1
    fi

    if [[ "$1" != *.md ]]; then
        echo "Error: the file must have a .md extension."
        return 1
    fi

    if [[ "$2" != *.css ]]; then
        echo "Error: the style file must have a .css extension."
        return 1
    fi


    local css_file=$2
    local output_file="${1%.md}.pdf"
    pandoc "$1" -o "$output_file" \
        --css="$css_file" \
        --highlight-style=pygments \
        --pdf-engine=weasyprint

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

mp4_convert() {
    local input_file="$1"

    # 1. Verify input and file existence
    if [[ -z "$input_file" ]]; then
        echo "Error: Please provide a video file."
        echo "Usage: mp4_convert <filename.ext>"
        return 1
    fi

    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found."
        return 1
    fi

    # 2. Extract filename and extension
    local filename="${input_file%.*}"
    local extension="${input_file##*.}"

    # Convert extension to lowercase for reliable matching across OSes
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    local output_file="${filename}.mp4"

    # 3. Handle the extension
    case "$extension" in
        mp4)
            echo "Notice: '$input_file' is already an MP4. Skipping conversion."
            return 0
            ;;
        webm|mkv|avi|mov|flv|wmv|m4v)
            echo "Recognized format '$extension'. Converting to MP4..."
            ;;
        *)
            echo "Warning: Unrecognized extension '$extension'. Attempting conversion anyway..."
            ;;
    esac

    # Prevent overwriting if something goes wrong with the naming logic
    if [[ "$input_file" == "$output_file" ]]; then
        output_file="${filename}_converted.mp4"
    fi

    # 4. Execute FFmpeg with maximum compatibility parameters
    ffmpeg -i "$input_file" \
        -c:v libx264 \
        -preset fast \
        -crf 23 \
        -pix_fmt yuv420p \
        -c:a aac \
        -b:a 192k \
        -movflags +faststart \
        "$output_file"

    # 5. Check if the conversion was successful
    if [[ $? -eq 0 ]]; then
        echo "✅ Success: Saved as '$output_file'"
    else
        echo "❌ Error: FFmpeg encountered an issue during conversion."
        return 1
    fi
}

ogg_convert() {
    local input_file="$1"

    # 1. Verify input and file existence
    if [[ -z "$input_file" ]]; then
        echo "Error: Please provide a media file."
        echo "Usage: ogg_convert <filename.ext>"
        return 1
    fi

    if [[ ! -f "$input_file" ]]; then
        echo "Error: File '$input_file' not found."
        return 1
    fi

    # 2. Extract filename and extension
    local filename="${input_file%.*}"
    local extension="${input_file##*.}"

    # Convert extension to lowercase for reliable matching across OSes
    extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')
    local output_file="${filename}.ogg"

    # 3. Handle the extension
    case "$extension" in
        ogg)
            echo "Notice: '$input_file' is already an OGG file. Skipping conversion."
            return 0
            ;;
        mp3|wav|flac|m4a|aac|wma)
            echo "Recognized audio format '$extension'. Converting to OGG Vorbis..."
            ;;
        mp4|mkv|avi|mov|webm|flv)
            echo "Notice: Recognized video format '$extension'. Extracting and converting audio to OGG..."
            ;;
        *)
            echo "Warning: Unrecognized extension '$extension'. Attempting conversion anyway..."
            ;;
    esac

    # Prevent overwriting if something goes wrong with the naming logic
    if [[ "$input_file" == "$output_file" ]]; then
        output_file="${filename}_converted.ogg"
    fi

    # 4. Execute FFmpeg with optimal OGG Vorbis parameters
    ffmpeg -i "$input_file" \
        -c:a libvorbis \
        -q:a 5 \
        -vn \
        "$output_file"

    # 5. Check if the conversion was successful
    if [[ $? -eq 0 ]]; then
        echo "✅ Success: Saved as '$output_file'"
    else
        echo "❌ Error: FFmpeg encountered an issue during conversion."
        return 1
    fi
}

ytdl() {
    local id="$1"
    local mode="${2:-VIDEO}"
    local range="$3"
    local url="https://www.youtube.com/watch?v=${id}"

    if [[ -z "$id" ]]; then
        echo "Usage: ytdl VIDEO_ID [VIDEO|AUDIO] [*START-END]" >&2
        echo "Example: ytdl ZnmnpWKoUS0 VIDEO '*02:00-02:10'" >&2
        return 1
    fi

    case "${mode^^}" in
        VIDEO)
            if [[ -n "$range" ]]; then
                yt-dlp \
                    -f "bv*+ba/b" \
                    --download-sections "$range" \
                    --force-keyframes-at-cuts \
                    --merge-output-format mp4 \
                    "$url"
            else
                yt-dlp \
                    -f "bv*+ba/b" \
                    --merge-output-format mp4 \
                    "$url"
            fi
            ;;

        AUDIO)
            if [[ -n "$range" ]]; then
                yt-dlp \
                    -f "ba/b" \
                    -x \
                    --audio-format mp3 \
                    --download-sections "$range" \
                    --force-keyframes-at-cuts \
                    "$url"
            else
                yt-dlp \
                    -f "ba/b" \
                    -x \
                    --audio-format mp3 \
                    "$url"
            fi
            ;;

        *)
            echo "Invalid mode: $mode" >&2
            echo "Use VIDEO or AUDIO" >&2
            return 1
            ;;
    esac
}
