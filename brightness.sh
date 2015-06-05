#!/bin/bash

[[ -z $1 ]] && dbright=30 || dbright=$1
[[ -z $2 ]] && mbright=1  || mbright=$2

curr=$(cat /sys/class/backlight/intel_backlight/brightness)
max=$(cat  /sys/class/backlight/intel_backlight/max_brightness)

new=$( echo "( $mbright * $curr ) + $dbright" | bc | cut -d"." -f1 )

echo $new

if [[ $new -lt 0    ]]; then new=0;    fi
if [[ $new -gt $max ]]; then new=$max; fi

echo $new

echo $new >> /sys/class/backlight/intel_backlight/brightness


