#!/bin/bash

# Get memory used and total from `free -g` or `free -h`
read used total <<< $(free -m | awk '/Mem:/ {printf "%.2f %.2f", $3/1024, $2/1024}')
echo "$used ($total GB)"

