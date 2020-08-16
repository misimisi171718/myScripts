#!/bin/bash

#sets a walpaper with nitrogen and it can also set video as walpaper but you need xwinwrap and mpv

killwin()
{
	if [ -f /tmp/WALLPAPER_PID ]
	then
		WALLPAPER_PID=$(cat /tmp/WALLPAPER_PID)
		kill -s 15 $WALLPAPER_PID
		rm /tmp/WALLPAPER_PID
	fi
}

if [ -z $1 ]
then
	path=/home/misi/Pictures/wallpapers
	while [ -d $path ]
	do
		x=$(ls $path | dmenu)
		if [ $x ]
		then
			path=$path/$x
		else
			exit 0
		fi
	done
else
	path=$1
fi

ext=$(echo $path | awk -F "." '{print $NF}')

if [ 'gif' = $ext ] || [ 'webm' = $ext ] || [ 'mkv' = $ext ]
then 
	killwin
	res=$(xrandr | awk '/ connected / {print $4}')
	xwinwrap -ov -g $res -- mpv -wid WID "$path" --no-osc --no-osd-bar --loop-file --player-operation-mode=cplayer --no-audio --panscan=1.0 --no-input-default-bindings &>/dev/null&
	echo $! > /tmp/WALLPAPER_PID
else
	killwin
	nitrogen --set-zoom-fill "$path"
fi
