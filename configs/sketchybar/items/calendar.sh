#!/bin/bash

sketchybar --add item clock right \
           --set clock update_freq=10 \
                       icon= \
                       script="$PLUGIN_DIR/clock.sh" \
           --add item calendar right \
           --set calendar update_freq=30 \
                          icon=󰸘 \
                          script="$PLUGIN_DIR/calendar.sh"
