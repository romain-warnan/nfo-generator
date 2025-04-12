#!/bin/bash

NONE_FOLDER="$1"
find "$NONE_FOLDER" -mindepth 1 -type f -name "*.nfo.none" -exec ./one-none.sh "{}" "$NONE_FOLDER" \;