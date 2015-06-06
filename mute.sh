#!/bin/bash

# Notify the user of the mute
echo "-e 1000 -u low (Un)Muted Audio" >> /tmp/notify-script &

# If the speaker has been automatically switched off,
# reenable it.
amixer -c 1 set Speaker on
# Toggle the master. If toggling off, this may disable the speaker
amixer -c 1 set Master toggle
