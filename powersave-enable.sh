avail=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies)
minfreq=$(for i in $avail; do echo $i; done | sort -n | head -n 1)

echo "Powersave CPU Mode enabled<br>Freq: $(($minfreq / 1000))MHz" >> /tmp/notify-script &

echo "userspace" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "userspace" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo "userspace" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo "userspace" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor

echo "$minfreq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
echo "$minfreq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_setspeed
echo "$minfreq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_setspeed
echo "$minfreq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_setspeed
