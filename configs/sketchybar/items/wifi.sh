#!/bin/bash

sketchybar --add item wifi right \
           --set wifi script="$PLUGIN_DIR/wifi.sh" \
                      icon="$WIFI_CONNECTED" \
                      update_freq=10
