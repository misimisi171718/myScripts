#!/bin/sh

# script to set pulseaudio output divice

list=$(pactl list short sink-inputs | awk '{print $1}')

echo $list

x=$(pactl list short sinks | awk '{print $2}' | dmenu)
x=$(pactl list short sinks | grep $x | awk '{print $1}')

pactl set-default-sink $x

for i in $list
do
	pactl move-sink-input $i $x
done
