#!/bin/bash

MOVIE_FOLDER="$1"
OUTPUT_DIRECTORY=${2:-.}
find "$MOVIE_FOLDER" -mindepth 1 -type f \( -iname "*.avi" -o -name "*.mkv" -o -name "*.mp4" \) -exec ./nfo.sh "{}" "$OUTPUT_DIRECTORY" \;