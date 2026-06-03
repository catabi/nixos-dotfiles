Bash

#!/bin/sh

# Determine the action (moving a window vs switching workspace view)
if [ "$1" = "window" ]; then
  category="swaymsg move container to workspace number"
  shift
else
  category="swaymsg workspace number"
fi

direction="$1" # Expects "next" or "prev"

# Parse the workspace layout dynamically using jq
target_workspace=$(swaymsg -t get_workspaces | jq --arg dir "$direction" -r '
  # 1. Store the full array of workspaces to preserve context
  . as $w |
  
  # 2. Identify the currently focused workspace
  (.[] | select(.focused == true)) as $focused |
  
  # 3. Get a sorted list of all active workspace numbers on this same output
  [ $w[] | select(.output == $focused.output) | .num ] | sort as $local_list |
  
  # 4. Get a list of all active workspace numbers globally to avoid hitting other monitors
  [ $w[] | .num ] as $global_list |
  
  # 5. Find the position index of our current workspace in the local list
  ($local_list | index($focused.num)) as $idx |
  
  # 6. Calculate the target workspace based on direction
  if $dir == "next" then
    if $idx + 1 < ($local_list | length) then
      # Go to the next existing workspace on this monitor
      $local_list[$idx + 1]
    else
      # CREATE NEW: Find the first integer greater than current that isn't active anywhere else
      [range($focused.num + 1; $focused.num + 20)] | map(select(. as $n | $global_list | index($n) | not)) | .[0]
    fi
  elif $dir == "prev" then
    if $idx - 1 >= 0 then
      # Go to the previous existing workspace on this monitor
      $local_list[$idx - 1]
    else
      # BACKTRACK/CREATE: Find a lower unused workspace number (down to a floor of 1)
      [range(1; $focused.num)] | reverse | map(select(. as $n | $global_list | index($n) | not)) | .[0]
    fi
  else
    empty
  fi
')

# Execute the action if a valid workspace number was returned
if [ -n "$target_workspace" ] && [ "$target_workspace" != "null" ]; then
  $category "$target_workspace"
else
  exit 1
fi
