#!/usr/bin/env sh

toggle_i3_class() {
    class="$1"
    tree="$(i3-msg -t get_tree)"

    # Is there a visible window with this class?
    if printf '%s\n' "$tree" | jq -e --arg class "$class" '
        .. | objects
        | select(.type? == "workspace" and .name? != "__i3_scratch")
        | .. | objects
        | select(.window_properties.class? == $class)
    ' >/dev/null; then
        i3-msg "[class=\"$class\"] move scratchpad" >/dev/null
        return 0
    fi

    # Is there a hidden scratchpad window with this class?
    if printf '%s\n' "$tree" | jq -e --arg class "$class" '
        .. | objects
        | select(.window_properties.class? == $class)
    ' >/dev/null; then
        i3-msg "[class=\"$class\"] scratchpad show, move position center" >/dev/null
        return 0
    fi

    # No window exists.
    return 1
}
