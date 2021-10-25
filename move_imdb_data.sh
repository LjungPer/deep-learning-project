#!/bin/bash

mkdir -p imdb_data
mkdir -p bw
num=0.1
bw_count=0
img_count=0
for dir in $1/imdb/*/; do
	for file in $dir*.jpg; do
		if (( $(echo "$(convert $file  -colorspace HSL -channel g -separate +channel -format "%[fx:mean]" info:) < $num" | bc) )); then 			mv "$file" ./bw/;
			printf 'Removed file %s\n' "$file";
			(( bw_count++ ));
		else
			mv "$file" ./imdb_data/;
			(( img_count++ ));
		fi
	done
done
printf 'Removed %d black and white images\nAdded %d images to /imdb_data/' "$bw_count" "$img_count";
