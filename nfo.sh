#!/bin/bash

MOVIE_FOLDER="$1"
echo "1. Recherche exacte"
./exact-unique-nfo.sh "$MOVIE_FOLDER" "$MOVIE_FOLDER/nfo"

echo "2. Recherche élargie"
./none-nfo.sh "$MOVIE_FOLDER/nfo/none"

echo "3. Recherche exacte avec année"
./many-nfo.sh "$MOVIE_FOLDER/nfo/many"
