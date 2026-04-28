#!/bin/sh

git-init() {
    set -e

    git init

    if command -v git-lfs >/dev/null 2>&1; then
        git lfs install
    else
        echo "ERROR: git-lfs not installed"
        return 1
    fi

    local assets_dir="$HOME/.config/shell/assets"
    local prettier_src="$assets_dir/gitprettierrc_default.txt"
    local license_src="$assets_dir/gitlicense_default.txt"

    if [ ! -f "$prettier_src" ]; then
        echo "ERROR: Missing $prettier_src"
        return 1
    fi

    if [ ! -f ".gitattributes" ]; then
        git-lfs-init
        echo "Default .gitattributes applied!"
    else
        echo "WARN: .gitattributes already exists, skipping git-lfs setup"
    fi

    if [ ! -f ".prettierrc" ]; then
        cp "$prettier_src" .prettierrc
        echo "Default .prettierrc applied!"
    else
        echo "WARN: .prettierrc already exists, skipping"
    fi

    if [ ! -f "LICENSE" ]; then
        cp "$license_src" LICENSE
        echo "Default LICENSE applied!"
    else
        echo "WARN: LICENSE already exists, skipping"
    fi

    if [ ! -f "README.md" ]; then
        touch README.md
        echo "Empty README.md created"
    fi

    if git remote get-url origin >/dev/null 2>&1; then
        echo "WARN: Remote 'origin' already exists, skipping"
    else
        local base_remote="ssh://git@git.rzuquim.com:2222/rzuquim"
        local repo_name
        repo_name="$(basename "$PWD")"
        local remote_url="${base_remote}/${repo_name}.git"

        git remote add origin "$remote_url"
        echo "Added remote: $remote_url"
    fi

    echo "Repository initialized with LFS and base configs"
}

function git-lfs-init() {
    # Image
    git lfs track "*.png"
    git lfs track "*.jpg"
    git lfs track "*.jpeg"
    git lfs track "*.gif"
    git lfs track "*.webp"
    git lfs track "*.psd"
    git lfs track "*.kra"
    git lfs track "*.tga"
    git lfs track "*.xcf"
    git lfs track "*.ai"
    git lfs track "*.avif"

    # 3D
    git lfs track "*.blend"
    git lfs track "*.fbx"
    git lfs track "*.exr"
    git lfs track "*.dds"

    # Video
    git lfs track "*.mp4"
    git lfs track "*.mov"
    git lfs track "*.avi"
    git lfs track "*.mkv"
    git lfs track "*.flac"
    git lfs track "*.prproj"
    git lfs track "*.drp"
    git lfs track "*.fcpbundle"
    git lfs track "*.aep"

    # Audio
    git lfs track "*.mp3"
    git lfs track "*.wav"
    git lfs track "*.ogg"
    git lfs track "*.m4a"
    git lfs track "*.aup3"
    git lfs track "*.als"
    git lfs track "*.flp"
    git lfs track "*.logicx"

    # Fonts
    git lfs track "*.ttf"
    git lfs track "*.otf"

    # Office stuff
    git lfs track "*.doc"
    git lfs track "*.docx"
    git lfs track "*.xls"
    git lfs track "*.xlsx"
    git lfs track "*.ppt"
    git lfs track "*.pptx"
    git lfs track "*.odt"
    git lfs track "*.ods"
    git lfs track "*.odp"
    git lfs track "*.pdf"
    git lfs track "*.excalidraw"
}

