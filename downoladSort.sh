#!/bin/bash

move()
{
	folder="/home/misi/Downloads/$2"
	file="/home/misi/Downloads/$1"
	if [ -d $folder ]
	then
		mv $file $folder
	else
		mkdir $folder
		mv $file $folder
	fi
}

files=$(ls ~/Downloads -p | grep -v /)
IFS=$'\n'
for i in $files
do
	ext=$(echo $i | awk -F  "." '{print $NF}')
	#echo $ext
	if [ $ext = "jpg" ] || [ $ext = "gif" ] || [ $ext = "png" ] || [ $ext = "jpeg" ] || [ $ext = "svg" ]
	then
		echo "image"
		move $i image 
	elif [ $ext = "torrent" ]
	then
		echo "torrent"
		move $i torrent
	elif [ $ext = "pdf" ]
	then
		echo "pdf"
		move $i pdf
	elif [ $ext = "odf" ] || [ $ext = "docx" ] || [ $ext = "doc" ] || [ $ext = "odt" ] || [ $ext = "ppt" ]
	then
		echo "doc"
		move $i doc
	elif [ $ext = "zip" ] || [ $ext = "gz" ] || [ $ext = "xz" ] || [ $ext = "rar" ] || [ $ext = "tar" ]
	then
		echo "compresd"
		move $i compresed
	elif [ $ext = "jar" ]
	then
		echo "jar"
		move $i jar
	elif [ $ext = "deb" ]
	then
		echo "deb"
		move $i deb
	elif [ $ext = "mp3" ]
	then
		echo "audio"
		move $i audio
	elif [ $ext = "mkv" ] || [ $ext = "mp4" ]
	then
		echo "video"
		move $i video
	elif [ $ext = "iso" ]
	then
		echo "iso"
		move $i iso
	else
		echo "else $ext"
	fi
done
