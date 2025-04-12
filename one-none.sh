#!/bin/bash

NONE_FILE=$(basename "$1")
OUTPUT_DIRECTORY="$2"
echo "'$NONE_FILE'"
MOVIE_NAME=$(echo "${NONE_FILE%.nfo.none}" | sed -E 's: \([0-9]{4}\)::')
echo "$MOVIE_NAME"
HEADER_USER_AGENT="Mozilla/5.0"
HEADER_ACCEPT="text/html"
IMDB_ID_MOVIE_NAME_REGEX="/title/(tt[0-9]+)/[^>]+>([^<]+)<"
IMDB_URL="https://www.imdb.com/fr/find/"
PARAM_MOVIE_NAME="q=${MOVIE_NAME}"
PARAM_MOVIE_NAME=$(echo "$PARAM_MOVIE_NAME" | sed -E "s:\s+:%20:g")
PARAM_S="s=tt"
echo "Fetching IMDB ID for movie: '$MOVIE_NAME'"
IMDB_IDS_NAMES=$(curl --get \
  --silent \
  --header "User-Agent: $HEADER_USER_AGENT" \
  --header "Accept: $HEADER_ACCEPT" \
  --data "$PARAM_MOVIE_NAME" \
  --data $PARAM_S \
  --location "$IMDB_URL" | \
  grep -Po "${IMDB_ID_MOVIE_NAME_REGEX}" | \
  sed -nE "s:${IMDB_ID_MOVIE_NAME_REGEX}:\1;\2:p" | \
  sed -E ":^\s*$:d")
NUMBER_OF_IDS=$(echo "$IMDB_IDS_NAMES" | wc -l)
if [ "$NUMBER_OF_IDS" -ge 1 ]; then
  IMDB_ID_NAME=$(echo "$IMDB_IDS_NAMES" | head -n 1)
  if [ -z "$IMDB_ID_NAME" ]; then
    echo "No IMDB ID found for movie: '$MOVIE_NAME'"
  else
    NFO_FILE="${NONE_FILE%.none}"
    IMDB_ID=$(echo "$IMDB_ID_NAME" | cut -f1 -d';')
    MOVIE_NAME=$(echo "$IMDB_ID_NAME" | cut -f2 -d';')
    export IMDB_ID
    export MOVIE_NAME
    echo "Creating NFO file: $NFO_FILE with IMDB id $IMDB_ID and name '$MOVIE_NAME'"
    envsubst < "template.nfo" > "$OUTPUT_DIRECTORY/$NFO_FILE"
    unset IMDB_ID
    unset MOVIE_NAME
  fi
fi

