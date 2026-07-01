#!/usr/bin/env bash

APP_DIR="$HOME/.local/share/applications"

for file in "$APP_DIR"/*waydroid*.desktop; do
  [ -e "$file" ] || continue

  echo "Updating: $(basename "$file")"

  awk '
    BEGIN { inserted = 0 }

    {
        print $0

        # When we are inside [Desktop Entry] and find Name=
        if ($0 ~ /^Name=/ && inserted == 0) {
            print "NoDisplay=true"
            inserted = 1
        }
    }
    ' "$file" >"$file.tmp" && mv "$file.tmp" "$file"

done

echo "Done."
