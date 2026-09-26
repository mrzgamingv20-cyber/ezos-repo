#!/bin/sh
# generate-index.sh - Auto-generate index.json from .tar.gz files
# Usage: cd packages && sh generate-index.sh
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
OUT="$DIR/index.json"
TMP="$OUT.tmp"

echo "{" > "$TMP"
first=1
for tarball in "$DIR"/*.tar.gz; do
    [ -f "$tarball" ] || continue
    name=$(basename "$tarball" .tar.gz)
    [ "$name" = "index" ] && continue
    [ "$name" = "CHECKSUMS" ] && continue
    [ "$name" = "generate-index" ] && continue

    if [ $first -eq 1 ]; then
        first=0
    else
        echo "," >> "$TMP"
    fi
    printf '  "%s": "%s"' "$name" "$name" >> "$TMP"
done
echo "" >> "$TMP"
echo "}" >> "$TMP"
mv "$TMP" "$OUT"
echo "Generated $OUT"