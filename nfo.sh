#!/bin/bash

MOVIE_FOLDER="$1"
OUTPUT_DIRECTORY=$MOVIE_FOLDER/nfo
find "$MOVIE_FOLDER" -mindepth 1 -type f \( -iname "*.avi" -o -name "*.mkv" -o -name "*.mp4" \) -exec ./one-exact-unique.sh "{}" "$OUTPUT_DIRECTORY" \;