#!/bin/bash
# Stop any XFCE keyboard daemon if it's running
killall ibus-daemon
killall fcitx
pkill xfsettingsd

# Set the keyboard layout
setxkbmap -layout us,ro -model pc105 -option 'grp:alt_shift_toggle,ctrl:nocaps'
