#!/bin/bash

declare -A sites=(
    ["󰖬  Wikipedia"]="https://en.wikipedia.org/wiki/Special:Search?search=%s"
    ["  YouTube"]="https://www.youtube.com/results?search_query=%s"
    ["  Google"]="https://www.google.com/search?q=%s"
    ["󰇥  DuckDuckGo"]="https://duckduckgo.com/?q=%s"
    ["  Chat GPT"]="https://chatgpt.com"
    ["  Nerd Font Icons"]="https://www.nerdfonts.com/cheat-sheet?q=%s"
)

chosen_site=$(for site in "${!sites[@]}"; do
    echo "$site"
done | wofi --dmenu --prompt "Bookmarks"  --insensitive --matching=fuzzy)

if [ "$chosen_site" == "" ]; then
    exit 1
fi

for site_id in "${!sites[@]}"; do
    if [ "$chosen_site" == "$site_id" ]; then
        url="${sites[$site_id]}"
        break
    fi
done

if [[ "$url" == *"%s"* ]]; then
    query=$(wofi --dmenu --prompt "Enter search query")
    query=$(jq -rn --arg v "$query" '$v|@uri')

    if [[ -n "$query" ]]; then
        url="${url//%s/$query}"
    fi
fi

if pgrep -x "librewolf" > /dev/null; then
    librewolf -P default --new-tab $url &
else
    librewolf -P default $url &
fi

hyprctl dispatch workspace "name:web"

