#!/bin/bash

# Simple space plugin
if [ "$SENDER" = "mouse.clicked" ]; then
  yabai -m space --focus $SID 2>/dev/null || true
fi

# Get current space info
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index' 2>/dev/null || echo "")
if [ "$CURRENT_SPACE" = "$SID" ]; then
  sketchybar --set $NAME icon.highlight=on
else
  sketchybar --set $NAME icon.highlight=off
fi
