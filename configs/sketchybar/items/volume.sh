#!/bin/bash

sketchybar --add item wifi right \
           --set wifi script="$PLUGIN_DIR/wifi.sh" \
                      icon="$WIFI_CONNECTED" \
           --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
           --subscribe volume volume_change \
           --add item cpu right \
           --set cpu update_freq=2 \
                     icon=󰘚 \
                     script="$PLUGIN_DIR/cpu.sh"
