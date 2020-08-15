#!/bin/sh

while [ true ]
do
	paths=$(find $1 -type f | sort -R)
	for i in $paths
	do
		/home/misi/.scripts/wallpaper.sh $i
		if [ $2 ]
		then
			sleep $2
 		else
			sleep 5
		fi
	done
done
