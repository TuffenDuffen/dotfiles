#!/bin/sh

get_status() 
{
	date_formatted=$(date "+%a %F %H:%M")

	battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
	battery_status=$(cat /sys/class/power_supply/BAT0/status)
	
	if [ $battery_status = "Charging" ]
	then
		battery_symbol="󰂄"
	elif [ $battery_level -lt 30 ]
	then
		battery_symbol="󱊡"
	elif [ $battery_level -lt 60 ]
	then
		battery_symbol="󱊢"
	else
		battery_symbol="󱊣"
	fi

	volume_level=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tr -dc '[:digit:]' | numfmt)
	case $(wpctl get-volume @DEFAULT_AUDIO_SINK@) in
		*MUTED*) volume="󰸈" ;;
		*) volume=" ${volume_level}%"
	esac

	echo "${volume} ${battery_symbol}${battery_level}%" $date_formatted
}
