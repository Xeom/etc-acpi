echo NONONONONO

avail=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)
minfreq=$(for i in $avail; do echo $i; done | sort -n | head -n 1)

maxfreq="1800000"

echo "Conservative CPU Mode Enabled<br>Min: $((minfreq / 1000))MHz Max: $((maxfreq / 1000))MHz" >> /tmp/notify-script &

echo "conservative" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "conservative" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "conservative" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "conservative" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

echo "$minfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo "$minfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

echo "$maxfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo "$maxfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq

echo NONONONO
exit 0
