#!/bin/bash

# TODO: detect city
CITY="São Paulo"
# TODO: escape cuty
CITY_ESCAPED="Sao+Paulo"
WEATHER=$(curl -s "wttr.in/$CITY_ESCAPED?format=%C+%t")
CONDITION=$(echo $WEATHER | sed -E 's/(.*)\s([\+\-].*)/\1/')
TEMP=$(echo $WEATHER | sed -E 's/(.*)\s([\+\-].*)/\2/')

declare -A WEATHER_ICONS=(
    ["clear"]="☀️"
    ["sunny"]="☀️"
    ["cloud"]="☁️"
    ["overcast"]="☁️"
    ["rain"]="🌧"
    ["shower"]="🌦"
    ["drizzle"]="🌦"
    ["thunder"]="⛈️"
    ["storm"]="⛈️"
    ["snow"]="❄️"
    ["mist"]="🌫️"
    ["fog"]="🌫️"
)

# Default icon
ICON="🌈"

LOWER_CONDITION=$(echo "$CONDITION" | tr '[:upper:]' '[:lower:]')
for keyword in "${!WEATHER_ICONS[@]}"; do
    if [[ "$LOWER_CONDITION" == *"$keyword"* ]]; then
        ICON="${WEATHER_ICONS[$keyword]}"
        break
    fi
done

if [ "$ICON" == "🌈" ]; then
    echo "$CITY, $ICON $TEMP ($CONDITION)"
else
    echo "$CITY, $ICON $TEMP"
fi
