#!/bin/bash

# Get dbright and mbright params from args if they exist
# if not, use defaults
[[ -z $1 ]] && dbright=30 || dbright=$1
[[ -z $2 ]] && mbright=1  || mbright=$2

# Get current and maximum possible brightnesses
curr=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat  /sys/class/backlight/intel_backlight/max_brightness)

# Get the new value, and strip off the decimal point
new=$( echo "$mbright * ($curr + $dbright)" | bc | cut -d"." -f1 )

# Apply limits to the new value
if [[ $new -lt 0    ]]; then new=0;    fi
if [[ $new -gt $max ]]; then new=$max; fi

# Update the backlight value
echo $new >> /sys/class/backlight/intel_backlight/brightness


