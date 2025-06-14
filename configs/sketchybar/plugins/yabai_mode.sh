#!/bin/bash

# Simple yabai mode plugin
YABAI_MODE=$(yabai -m query --spaces --space | jq -r '.type' 2>/dev/null || echo "unknown")

case "$YABAI_MODE" in
  "bsp")
    sketchybar --set $NAME label="BSP"
    ;;
  "stack")
    sketchybar --set $NAME label="STACK"
    ;;
  "float")
    sketchybar --set $NAME label="FLOAT"
    ;;
  *)
    sketchybar --set $NAME label=""
    ;;
esac
