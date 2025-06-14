#!/bin/bash

sketchybar --add item yabai_mode left \
           --set yabai_mode script="$PLUGIN_DIR/yabai_mode.sh" \
                            icon.drawing=off \
           --subscribe yabai_mode space_change
