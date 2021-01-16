#!/bin/bash
# #
SLEEP_SEC=3  # set bar_delay = 5 in /etc/spectrwm.conf

print_bat() {
	# print battery status and percentage
	PERCENT=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep 'percentage' | awk '{print $2}'`
	x="${PERCENT%?}"
	STATE=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep 'state' | awk '{print $2}'`
	
	if [ $STATE = "discharging" ]
	then
		
		if [ $x -le 100 ] && [ $x -gt 90 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 90 ] && [ $x -gt 80 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 80 ] && [ $x -gt 70 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 70 ] && [ $x -gt 60 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 60 ] && [ $x -gt 50 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 50 ] && [ $x -gt 40 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 40 ] && [ $x -gt 30 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 30 ] && [ $x -gt 20 ]
		then
			echo -n " $PERCENT"
		elif [ $x -le 20 ] && [ $x -ge 00 ]
		then
			echo -n " $PERCENT"
		elif [ $x -e 10 ]
		then
			notify-send -u critical '10% battery remaining' 'plug me in!!'
		fi
	elif [ $STATE = "charging" ]
	then
		echo -n " $PERCENT"
	else
		echo -n " $PERCENT"
	fi

}

print_bright() {
	# print backlight brightness
	BRIGHT=`xbacklight -get | grep '' | awk '{print int($1+0.5)}'`
	echo -n " 盛 $BRIGHT%"
}

print_volume() {
	# print system volume
	STATS=`pacmd list-sinks`
	VOLUME=`echo "$STATS" | grep "front-left:" | awk '{print $5}'`
	
	MUTE=`echo "$STATS" | grep "muted:" | awk '{print  $2}'`

	if [ $MUTE = "no" ]
	then
		echo -n "  $VOLUME"
	else
		echo -n -e "  muted"
	fi
}

print_wifi() {
	# print wifi ssid
	STATS=`iw wlp7s0 info`
	SSID=`echo "$STATS" | grep "ssid" | awk '{print $2}'`
	# STATUS=`nmcli dev wifi`
	# SSID=`echo "$STATUS" | awk '{print $2}' | tail -n 1`
	# SIGNAL=`echo "$STATUS" | awk '{print $7}' | tail -n 1`
	echo -n "  $SSID"
}

while :; do
	
	print_wifi
	echo -n "  "
	print_bat
	echo -n " "
	print_bright
	echo -n " "
	print_volume
	echo -n " "
	
	# let COUNT=$COUNT+1
    echo ""
    sleep $SLEEP_SEC


done


# print_date() {
# 	# The date is printed to the status bar by default.
# 	# To print the date through this script, set clock_enabled to 0
# 	# in spectrwm.conf.  Uncomment "print_date" below.
# 	# FORMAT="%a %b %d %R %Z %Y"
# 	FORMAT="%m-%d %a %I:%M %p"
# 	DATE=`date "+${FORMAT}"`
# 	echo -n "${DATE}     "
# }

# print_mem() {
# 	MEM=`/usr/bin/top | grep Free: | cut -d " " -f6`
# 	echo -n "Free mem: $MEM  "
# }

# _print_cpu() {
# 	typeset -R4 _1=${1} _2=${2} _3=${3} _4=${4} _5=${5}
# 	echo -n "CPU:${_1}% User${_2}% Nice${_3}% Sys${_4}% Int${_5}% Idle  "
# }

# print_cpu() {
# 	OUT=""
# 	# iostat prints each column justified to 3 chars, so if one counter
# 	# is 100, it jams up agains the preceeding one. sort this out.
# 	while [ "${1}x" != "x" ]; do
# 		if [ ${1} -gt 99 ]; then
# 			OUT="$OUT ${1%100} 100"
# 		else
# 			OUT="$OUT ${1}"
# 		fi
# 		shift;
# 	done
# 	_print_cpu $OUT
# }

# print_apm() {
# 	BAT_STATUS=$1
# 	BAT_LEVEL=$2
# 	AC_STATUS=$3

# 	if [ $AC_STATUS -ne 255 -o $BAT_STATUS -lt 4 ]; then
# 		if [ $AC_STATUS -eq 0 ]; then
# 			echo -n "on battery (${BAT_LEVEL}%)"
# 		else
# 			case $AC_STATUS in
# 			1)
# 				AC_STRING="on AC: "
# 				;;
# 			2)
# 				AC_STRING="on backup AC: "
# 				;;
# 			*)
# 				AC_STRING=""
# 				;;
# 			esac;
# 			case $BAT_STATUS in
# 			4)
# 				BAT_STRING="(no battery)"
# 				;;
# 			[0-3])
# 		 		BAT_STRING="(battery ${BAT_LEVEL}%)"
# 				;;
# 			*)
# 				BAT_STRING="(battery unknown)"
# 				;;
# 			esac;

# 			FULL="${AC_STRING}${BAT_STRING}"
# 			if [ "$FULL" != "" ]; then
# 				echo -n "$FULL"
# 			fi
# 		fi
# 	fi
# }

# print_cpuspeed() {
# 	CPU_SPEED=`/sbin/sysctl hw.cpuspeed | cut -d "=" -f2`
# 	echo -n "CPU speed: $CPU_SPEED MHz  "
# }

# while :; do
# 	# instead of sleeping, use iostat as the update timer.
# 	# cache the output of apm(8), no need to call that every second.
# 	/usr/bin/iostat -C -c 3600 |&	# wish infinity was an option
# 	PID="$!"
# 	APM_DATA=""
# 	I=0
# 	trap "kill $PID; exit" TERM
# 	while read -p; do
# 		if [ $(( ${I} % 1 )) -eq 0 ]; then
# 			APM_DATA=`/usr/bin/apm -alb`
# 		fi
# 		if [ $I -ge 2 ]; then
			
# 			print_wifi
# 			echo -n "  "
# 			print_bat
# 			echo -n " "
# 			print_bright
# 			echo -n " "
# 			print_volume
# 			echo -n " "
			
			
			
# 			echo ""
# 		fi
# 		I=$(( ( ${I} + 1 ) % 22 ));
# 	done
# done
