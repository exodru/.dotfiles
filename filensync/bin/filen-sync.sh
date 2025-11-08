#!/usr/bin/env bash

LOGFILE="$HOME/filen_sync.log"
echo "$(date +'%Y-%m-%d %H:%M:%S') — Starting sync" >>"$LOGFILE"
/home/prozod/.filen-cli/bin/filen sync /home/prozod/notes:/notes --verbose >>"$LOGFILE" 2>&1
echo "$(date +'%Y-%m-%d %H:%M:%S') — Sync done" >>"$LOGFILE"
