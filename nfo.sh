#!/bin/bash

MOVIE_FILE=$(basename "$1")
OUTPUT_DIRECTORY=${2:-.}
mkdir -p "$OUTPUT_DIRECTORY/none" "$OUTPUT_DIRECTORY/many"
echo "'$MOVIE_FILE'"
MOVIE_NAME=$(echo "${MOVIE_FILE%.*}" | sed -E 's: \([0-9]{4}\)::')
export MOVIE_NAME
HEADER_USER_AGENT="Mozilla/5.0"
HEADER_ACCEPT="text/html"
IMDB_ID_REGEX="/title/(tt[0-9]+)/"
IMDB_URL="https://www.imdb.com/fr/find/"
PARAM_MOVIE_NAME="q=${MOVIE_NAME}"
PARAM_TTYPE="ttype=ft"
PARAM_EXACT="exact=true"
PARAM_S="s=tt"
echo "Fetching IMDB ID for movie: '$MOVIE_NAME'"
IMDB_IDS=$(curl --get \
  --silent \
  --header "User-Agent: $HEADER_USER_AGENT" \
  --header "Accept: $HEADER_ACCEPT" \
  --data-urlencode "$PARAM_MOVIE_NAME" \
  --data-urlencode $PARAM_TTYPE \
  --data-urlencode $PARAM_EXACT \
  --data-urlencode $PARAM_S \
  --location "$IMDB_URL" | \
  grep -Po "${IMDB_ID_REGEX}" | \
  sed -nE "s:${IMDB_ID_REGEX}:\1:p" | \
  sed -E ":^\s*$:d")

NFO_FILE="${MOVIE_FILE%.*}.nfo"
NUMBER_OF_IDS=$(echo "$IMDB_IDS" | wc -l)
if [ "$NUMBER_OF_IDS" -gt 1 ]; then
  echo "Multiple IMDB IDs found for movie: '$MOVIE_NAME'"
  NFO_FILE="many/${MOVIE_FILE%.*}.nfo.many"
else
  IMDB_ID=$(echo "$IMDB_IDS" | head -n 1)
  if [ -z "$IMDB_ID" ]; then
    echo "No IMDB ID found for movie: '$MOVIE_NAME'"
    NFO_FILE="none/${MOVIE_FILE%.*}.nfo.none"
  else
    NFO_FILE="${MOVIE_FILE%.*}.nfo"
    echo "Found IMDB ID: $IMDB_ID"
    export IMDB_ID
  fi
fi

echo "Creating NFO file: $NFO_FILE"
envsubst < "template.nfo" > "$OUTPUT_DIRECTORY/$NFO_FILE"
unset IMDB_ID
unset MOVIE_NAME