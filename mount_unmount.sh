#!/bin/bash

menu=$(echo "mount"$'\n'"unmount" | dmenu)

if [ $menu = "mount" ]
then
	/home/misi/.scripts/dmenumount.sh
else
	/home/misi/.scripts/dmenuumount.sh
fi
