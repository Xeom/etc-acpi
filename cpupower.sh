#!/bin/bash

# Get all available frequency steps
avail=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)

# Get the highest and lowest frequencies available
minfreq=$(for i in $avail; do echo $i; done | sort -n | head -n 1)
maxfreq=$(for i in $avail; do echo $i; done | sort -n | tail -n 1)
cpunums=$(cat /proc/cpuinfo | grep "processor" | cut -d":" -f2 | xargs echo)

# A specific maximum for conservative mode
consfreq="1800000"

# Notify the user of the new configuration

case $1 in
max)
	echo "<b>FULL POWER</b> CPU Mode Enabled<br>Min: $((minfreq / 1000))MHz Max: $((maxfreq / 1000))MHz" >> /tmp/notify-script &

	for num in $cpunums
	do
# Select govenor
		echo "performance" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_governor
# Set minimum frequency to lowest possible
		echo "$minfreq" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_min_freq
# Set maximum frequency to highest possible
		echo "$maxfreq" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_max_freq
	done
;;
conservative)
	echo "Conservative CPU Mode Enabled<br>Min: $((minfreq / 1000))MHz Max: $((maxfreq / 1000))MHz" >> /tmp/notify-script &

	for num in $cpunums
	do
# Select govenor
		echo "conservative" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_governor
# Set minimum frequency to lowest possible
		echo "$minfreq" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_min_freq
# Set maximum frequency to whatever is configured
		echo "$consfreq" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_max_freq
	done
;;
min)
	echo "Powersave CPU Mode enabled<br>Freq: $(($minfreq / 1000))MHz" >> /tmp/notify-script &

	for num in $cpunums
	do
# Use a user-selected frequency
		echo "userspace" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_governor
# Use the lowest possible frequency
		echo "$minfreq" > /sys/devices/system/cpu/cpu${num}/cpufreq/scaling_setspeed
	done
;;
esac
