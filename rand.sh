#!/bin/sh

#sets a random image from the path given and changes it every five seconds

while [ true ]
do
	paths=$(find $1 -type f | sort -R)
	for i in $paths
	do
		/home/misi/git/myScripts/wallpaper.sh $i
		if [ $2 ]
		then
			sleep $2
 		else
			sleep 5
		fi
	done
done
