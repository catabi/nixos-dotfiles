#!/bin/sh

# Get the name of the currently focused monitor/output
current_output=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused).name')

# Get a sorted list of all existing workspaces across all monitors
all_workspaces=$(swaymsg -t get_workspaces | jq -r '.[].num' | sort -n)

# Get a sorted list of workspaces tracking only the current monitor
current_output_workspaces=$(swaymsg -t get_workspaces | jq -r ".[] | select(.output == \"$current_output\").num" | sort -n)

# Get the currently focused workspace number
current_workspace=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused).num')

# NEW: Look backward for the highest workspace number that is less than the current one
next_workspace=$(echo "$current_output_workspaces" | awk -v curr="$current_workspace" '$1 < curr {prev=$1} END {print prev}')

# If there is no workspace to the left, find the lowest unused workspace number globally
if [ -z "$next_workspace" ]; then
  next_available=$(comm -13 <(echo "$all_workspaces") <(seq 1 100) | head -n 1)
  swaymsg "workspace number $next_available"
else
  swaymsg "workspace number $next_workspace"
fi
