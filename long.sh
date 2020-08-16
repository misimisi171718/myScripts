#!/bin/bash

#fthis script findes files at ergument one that are longer then the legth given in argument two

files=$(find $1 -type f)
IFS=$'\n'
for i in $files
do
		  i="$i"
		  x=$(cat $i | wc -l)
		  if [ $x -gt $2 ]
		  then
					 echo "$i $x"
		  fi
done
