#!/bin/bash

MANY_FOLDER="$1"
find "$MANY_FOLDER" -mindepth 1 -type f -name "*.nfo.many" -exec ./one-many.sh "{}" "$MANY_FOLDER" \;