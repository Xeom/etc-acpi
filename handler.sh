#!/bin/bash

case "$1" in
ac_adapter)
	case "$4" in
	00000000)
		echo "<span foreground='red'>Unplugged from AC</span>" >> /tmp/notify-script &
		/etc/acpi/powersave-enable.sh
		;;
	00000001)
		echo "Plugged into AC" >> /tmp/notify-script &
		/etc/acpi/powerconservative-enable.sh
		;;
	esac
	;;
esac
