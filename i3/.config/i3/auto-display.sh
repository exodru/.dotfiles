#!/bin/bash

# Get all connected displays in order
DISPLAYS=($(xrandr | grep -w connected | awk '{print $1}'))

# Set the first as the primary display
PRIMARY=${DISPLAYS[0]}
xrandr --output "$PRIMARY" --auto --primary

# Position the rest to the right of the previous
PREV="$PRIMARY"
for DISP in "${DISPLAYS[@]:1}"; do
    xrandr --output "$DISP" --auto --right-of "$PREV"
    PREV="$DISP"
done

