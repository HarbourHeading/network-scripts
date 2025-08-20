#!/bin/bash
# This script reads a JSON configuration file and deletes old files in specified directories,
# keeping only the most recent ones based on a regex pattern. See example usage in README.md
#
# Author: Harbourheading
# Creation date: 2025-06-10

INPUT_FILE="log_locations.json"

DEBUG=false
if [ "$1" = "debug" ]; then
  DEBUG=true
fi

main() {
  # Read json file, defining vars according to data
  jq -r '.[] | "\(.directory)|\(.keep)|\(.regex)"' "$INPUT_FILE" |
  while IFS='|' read -r directory keep regex; do

    # Trim whitespace
    directory=$(echo "$directory" | xargs)
    keep=$(echo "$keep" | xargs)
    regex=$(echo "$regex" | xargs)

    echo "Processing directory: $directory"
    echo "Keeping newest $keep files matching: \"$regex\""

    # Find and sort files by modification time, list files beyond the keep count
    files=$(find "$directory" -type f -name "$regex" -print0 \
      | xargs -0 ls -1t 2>/dev/null \
      | tail -n +$((keep + 1)))

    # File(s) from filter exists
    if [ -n "$files" ]; then

      if $DEBUG; then
        echo "Files that would be deleted:"
        echo "$files"
      else
        echo "$files" | xargs -d '\n' rm -v --
      fi

    else
      echo "Nothing to delete in $directory"
    fi
  done
}

main
