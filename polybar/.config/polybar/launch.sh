#!/usr/bin/env bash


#!/bin/bash

# Kill any existing polybar instances
killall -q polybar

# Wait for them to close
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch a bar on each connected monitor
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  echo "Launching bar on monitor: $m"
  echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
  MONITOR=$m polybar mydefaultpb & 2>&1 | tee -a /tmp/polybar1.log & disown
  echo "Polybar launched..."
done
