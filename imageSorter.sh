#!/bin/bash

#sorts images at arugment one and organises them at argument two in directories by time

folders=$(find $1 -type f | sed 's/ /\\\ /g')
z=$(find $1 -type f | wc -l)
y="1"
IFS=$'\n'
for i in $folders
do
	echo -ne "$y/$z\r"
	y=$(($y+1))
	date=$(identify -verbose $i | grep DateTimeOriginal | awk '{print $2}')
	year=$(echo $date | awk -F ":" '{print $1}')
	month=$(echo $date | awk -F ":" '{print $2}')
	if [ ! -d "$2/$year/$month/" ]
       	then
		if [ -d "$2/$year/" ]
	       	then
			mkdir $2$year/$month
		else
			mkdir $2$year
			mkdir $2$year/$month
		fi
	fi
	fileName=$(echo $i | awk -F "/" '{print $NF}')
	duplica=$(ls $2$year/$month | grep $fileName)
	a="/"
	if [ -n "$duplica" ] 
	then
		comp=$(cmp -s $i $2$year/$month/$fileName && echo "1" || echo "0")
		if [ "$comp" -eq "0" ]
		then
			fileExt=$(echo $fileName | awk -F "." '{print $2}')
			fileName=$(echo $fileName | awk -F "." '{print $1}')
			x="1"
			b="_"
			finalName="$2$a$year$a$month$a$fileName$b$x$fileExt"
			while [ -f $finalName ]
			do
				x=$((x+1))
				finalName="$2$a$year$a$month$a$fileName$b$x$fileExt"
			done
			cp $i $finalName
		fi
	else
		cp $i $2$year/$month/$fileName
	fi
done
