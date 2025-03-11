#!/bin/bash

# loop taken from:
# https://stackoverflow.com/a/2108296/19860022

archivelist=""

for dir in /app/data/*/; do
  dir=${dir%*/}
  dir="${dir##*/}"
  archivelist+="${dir}.pxar:/app/data/${dir} "
done

echo $archivelist
