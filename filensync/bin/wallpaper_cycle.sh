#!/usr/bin/env bash

# Directory containing wallpapers
WPDIR="$HOME/walls/"

# File to remember last index
STATE="$HOME/.cache/wp-index"

# Generate file list (sorted)
mapfile -t FILES < <(find "$WPDIR" -maxdepth 1 \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | sort)

TOTAL=${#FILES[@]}
[[ $TOTAL -eq 0 ]] && echo "No wallpapers found in $WPDIR" && exit 1

# Load last index
if [[ -f "$STATE" ]]; then
    INDEX=$(<"$STATE")
else
    INDEX=0
fi

# Direction: next or prev
case "$1" in
    next)
        INDEX=$(( (INDEX + 1) % TOTAL ))
        ;;
    prev)
        INDEX=$(( (INDEX - 1 + TOTAL) % TOTAL ))
        ;;
    *)
        echo "Usage: wp-cycle {next|prev}"
        exit 1
        ;;
esac

# Save new index
echo "$INDEX" > "$STATE"

# Set wallpaper
feh --bg-fill "${FILES[$INDEX]}"

