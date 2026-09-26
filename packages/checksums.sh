#!/bin/sh
# checksums.sh - Generate and verify SHA256 checksums for packages
# Usage: cd packages && sh checksums.sh verify   (verify all)
#        cd packages && sh checksums.sh generate  (generate)
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
CHECKSUMS="$DIR/CHECKSUMS.sha256"

generate() {
    echo "Generating checksums..."
    > "$CHECKSUMS"
    for tarball in "$DIR"/*.tar.gz; do
        [ -f "$tarball" ] || continue
        name=$(basename "$tarball")
        sha=$(sha256sum "$tarball" | cut -d' ' -f1)
        echo "$sha  $name" >> "$CHECKSUMS"
        echo "  ✓ $name"
    done
    echo "Done: $CHECKSUMS"
}

verify() {
    [ -f "$CHECKSUMS" ] || { echo "No checksums file. Run: sh checksums.sh generate"; exit 1; }
    echo "Verifying checksums..."
    failed=0
    while IFS='  ' read -r sha name; do
        [ -z "$name" ] && continue
        file="$DIR/$name"
        [ -f "$file" ] || { echo "  ✗ $name MISSING"; failed=1; continue; }
        actual=$(sha256sum "$file" | cut -d' ' -f1)
        if [ "$sha" = "$actual" ]; then
            echo "  ✓ $name"
        else
            echo "  ✗ $name MISMATCH"
            failed=1
        fi
    done < "$CHECKSUMS"
    [ "$failed" -eq 0 ] && echo "All checksums valid!" || echo "Some checksums failed!"
}

case "${1:-}" in
    generate) generate ;;
    verify) verify ;;
    *) echo "Usage: sh checksums.sh [generate|verify]"; exit 1 ;;
esac
