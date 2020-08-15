#!/bin/sh
x=50
dir=1
while [ true ]
do
	if [ $dir = "1" ]
	then
		x=$((x+1))
  	else
		x=$((x-1))
	fi

	if [ $x = "100" ]
	then
		dir=0
	fi

	if [ $x = "0" ]
	then
		dir=1
	fi
	
	for W in $(wmctrl -l |grep Chrome |awk '{print $1}')
	do
		xprop -id $W -format _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $(printf 0x%x $((0xffffffff * $x / 100)))
	done
done
