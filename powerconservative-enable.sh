# Get a list of all available frequencies
avail=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)
# Find the lowest available frequency
minfreq=$(for i in $avail; do echo $i; done | sort -n | head -n 1)

# Have a specific maximum frequcency
maxfreq="1800000"

# Inform the user of the new setup
echo "Conservative CPU Mode Enabled<br>Min: $((minfreq / 1000))MHz Max: $((maxfreq / 1000))MHz" >> /tmp/notify-script &

# Use conservative govenor
echo "conservative" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "conservative" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "conservative" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "conservative" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

# Set minimum freq to lowest available
echo "$minfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

# Set maximum freq to whatever is configured
echo "$maxfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
