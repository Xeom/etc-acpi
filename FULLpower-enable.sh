avail=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)
minfreq=$(for i in $avail; do echo $i; done | sort -n | head -n 1)
maxfreq=$(for i in $avail; do echo $i; done | sort -n | tail -n 1)

echo "<b>FULL POWER</b> CPU Mode Enabled<br>Min: $((minfreq / 1000))MHz Max: $((maxfreq / 1000))MHz" >> /tmp/notify-script &

echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "performance" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

echo "$minfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

echo "$maxfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq

exit 0
