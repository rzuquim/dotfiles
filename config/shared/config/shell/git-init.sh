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
    local gitattributes_src="$assets_dir/gitattributes_default.txt"
    local prettier_src="$assets_dir/gitprettierrc_default.txt"
    local license_src="$assets_dir/gitlicense_default.txt"

    if [ ! -f "$gitattributes_src" ]; then
        echo "ERROR: Missing $gitattributes_src"
        return 1
    fi

    if [ ! -f "$prettier_src" ]; then
        echo "ERROR: Missing $prettier_src"
        return 1
    fi

    if [ ! -f ".gitattributes" ]; then
        cp "$gitattributes_src" .gitattributes
        echo "Default .gitattributes applied!"
    else
        echo "WARN: .gitattributes already exists, skipping"
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
