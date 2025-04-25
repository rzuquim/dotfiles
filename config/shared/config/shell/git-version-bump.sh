#!/bin/sh

function git-version-bump() {
    # NOTE: escaping regex special chars
    local version=$(echo "$1" | sed -e 's/[]\/$*.^[]/\\&/g')
    local default_patterns=("**/*.csproj" "**/package.json" "**/Cargo.toml" "**/pom.xml" "**/pyproject.toml")
    local file_patterns=("${@:2}")

    if [ ${#file_patterns[@]} -eq 0 ]; then
        file_patterns=("${default_patterns[@]}")
    fi

    for pattern in "${file_patterns[@]}"; do
        local candidates=($(git log -G"$version" --oneline -- "$pattern" | cut --fields 1 --delimiter=' '))
        for commit in $candidates; do
            if git show "$commit" -- "$pattern" | grep -q "^\+.*$version"; then
                echo "Version $1 was introduced in commit: $commit (file: $pattern)" >&2
                echo "$commit"
                return 0
            fi
        done
    done

    echo "Could not find version $1" >&2
    return 1
}

