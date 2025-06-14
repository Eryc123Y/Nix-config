#!/bin/bash

# Simple space plugin without yabai
if [ "$SENDER" = "mouse.clicked" ]; then
  # Use macOS native space switching instead of yabai
  # SID represents the space number
  osascript -e "tell application \"System Events\" to key code 18 using {control down}" 2>/dev/null || true
fi

# Simple highlighting based on click events
# Since we can't query yabai, we'll rely on the click feedback
sketchybar --set $NAME icon.highlight=off
