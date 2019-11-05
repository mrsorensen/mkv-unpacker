#!/bin/bash

# Location of torrent folder
dir="/torrents/"
# Sleep for x seconds
sleep=30

# Clear on startup
clear
# Keep looping every $sleep seconds
while :
do

	# Get a list of all directories in your target directory
	content=$(ls -d ${dir}*/)

	# Check each directory for .rar files, and extract any .mkv file
	# if the file is not extracted yet
	IFS=$'\n'
	for d in $content; do

		# Get a list of the content of the archive file
		mediafilename=$(unrar lb "$d"*.rar)
		# Get the name of the archive file
		rarfilename=$(ls $d | grep .rar)

		# Check if there is a .mkv file to be extracted
		if [[ "$mediafilename" = *.mkv ]]; then

			# Unrar the archive if the .mkv file is not extracted
			if [ ! -e "$d$mediafilename" ]; then
				echo "Extracting $rarfilename..."
				unrar e $d$rarfilename $d
			fi

		fi
	done

	# Countdown before looping again
	for (( i=$sleep; i>0; i-- ))
	do
		echo -ne "\rRechecking in "$i"s"
		sleep 1

	done


done
