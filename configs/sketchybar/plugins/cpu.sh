#!/bin/bash

# Simple CPU plugin
CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')

sketchybar --set $NAME icon="󰘚" label="$CPU_USAGE%"
