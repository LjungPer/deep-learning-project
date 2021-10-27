#!/bin/bash

# Pick samples of faces randomly from imdb_crop to imdb directory
mkdir -p imdb_data
samples=100
count=0
for dir in imdb_crop/*/; do 
	shuf -n $samples -e $dir*.jpg | xargs -i cp {} ./imdb_data;
	(( count++ ))
done
printf '%d images of faces moved to directory imdb_data/' "$(( count*samples ))";

# Create folder and move bw images to it
mkdir -p bw
num=0.1
count=0
for file in imdb_data/*.jpg; do 
	if (( $(echo "$(convert $file  -colorspace HSL -channel g -separate +channel -format "%[fx:mean]" info:) < $num" | bc) )); then 
		mv "$file" ./bw/;
		printf 'Removed file %s\n' "$file";
		(( count++ ))
	fi; 
done
printf 'Removed %d black and white images in total\n' "$count";
