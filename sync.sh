#!/bin/bash

RCLONE_CONFIG=/home/misi/.config/rclone/rclone.conf
export RCLONE_CONFIG
LOCKFILE="/tmp/`basename $0`"
sync=$(cat /home/misi/.scripts/sync.txt)
IFS=$'\n'

for i in $sync
do
	a=$(echo $i | awk '{print $1}')
	b=$(echo $i | awk '{print $2}')
	error=$(rclonesync $a $b)
	ernum=$?
	if [ $ernum -eq 2 ];then
		echo "doing first sync"
		rclonesync --first-sync $a $b
		echo $?
		echo "first sync done"
	elif [ $ernum -eq 0 ];then
		echo "ok"
	elif [ $ernum -eq 1 ];then
		echo -n "do you want to force sync (y/n)?"
		read ans
		if [ $ans = "y" ] || [ $ans = "Y" ];then
			rclonesync --force $a $b
		elif [ $ans = "n" ] || [ $ans = "N" ];then
			echo "skipping"
		else
			echo "invalid input skipping"
		fi
		
	else
		echo "error $ernum"
		echo $error
	fi
done
