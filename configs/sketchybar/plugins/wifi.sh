#!/bin/bash

# Simple wifi plugin
WIFI_INTERFACE=$(route get default | grep interface | awk '{print $2}' 2>/dev/null || echo "en0")
WIFI_STATUS=$(ifconfig $WIFI_INTERFACE 2>/dev/null | grep "status: active" > /dev/null && echo "connected" || echo "disconnected")

if [ "$WIFI_STATUS" = "connected" ]; then
  WIFI_SSID=$(networksetup -getairportnetwork $WIFI_INTERFACE 2>/dev/null | cut -d: -f2 | sed 's/^ *//' || echo "Connected")
  sketchybar --set $NAME icon="󰖩" label="$WIFI_SSID"
else
  sketchybar --set $NAME icon="󰖪" label="Disconnected"
fi
