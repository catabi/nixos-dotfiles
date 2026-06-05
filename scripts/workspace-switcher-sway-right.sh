#!/bin/sh

current_output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')

all_workspaces=$(swaymsg -t get_workspaces | jq -r '.[].num' | sort -n)

current_output_workspaces=$(swaymsg -t get_workspaces | jq -r ".[] | select(.output == \"$current_output\").num" | sort -n)

current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused).num')

next_workspace=$(echo "$current_output_workspaces" | awk -v curr="$current_workspace" '$1 > curr {print; exit}')

if [ -z "$next_workspace" ]; then

  next_available=$(comm -13 <(echo "$all_workspaces") <(seq 1 100) | head -n 1)

  swaymsg "workspace number $next_available"

else

  swaymsg "workspace number $next_workspace"

fi
