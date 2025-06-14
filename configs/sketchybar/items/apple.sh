#!/bin/bash

sketchybar --add item apple.logo left \
           --set apple.logo icon=$APPLE \
                            icon.font="Hack Nerd Font:Black:16.0" \
                            icon.color=$GREEN \
                            label.drawing=off \
                            click_script="sketchybar --set \$NAME popup.drawing=toggle" \
                            popup.height=35 \
           --add item apple.prefs popup.apple.logo \
           --set apple.prefs icon=$PREFERENCES \
                             label="Preferences" \
                             click_script="open -b com.apple.systempreferences; 
                                           sketchybar --set apple.logo popup.drawing=off" \
           --add item apple.activity popup.apple.logo \
           --set apple.activity icon=$ACTIVITY \
                                label="Activity Monitor" \
                                click_script="open -b com.apple.ActivityMonitor; 
                                              sketchybar --set apple.logo popup.drawing=off" \
           --add item apple.lock popup.apple.logo \
           --set apple.lock icon=$LOCK \
                            label="Lock Screen" \
                            click_script="pmset displaysleepnow; 
                                          sketchybar --set apple.logo popup.drawing=off"
