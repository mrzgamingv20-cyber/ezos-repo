#!/usr/bin/env bash
set -euo pipefail

# install_ezos.sh
# Usage: install_ezos.sh <pkg-name> <tarball-url>

EZOS_DIR="$HOME/.ezos"
PKG_NAME="${1:-ezos}"
URL="${2:-}"

if [ -z "$URL" ]; then
  echo "Usage: install_ezos.sh <pkg-name> <tarball-url>"
  exit 2
fi

mkdir -p "$EZOS_DIR/$PKG_NAME"

tmpfile="$(mktemp)"

echo "Downloading $URL ..."
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL" -o "$tmpfile"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$tmpfile" "$URL"
else
  echo "Install curl or wget in Termux first (pkg install curl wget)"
  exit 1
fi

echo "Extracting to $EZOS_DIR/$PKG_NAME ..."
tar -xzf "$tmpfile" -C "$EZOS_DIR/$PKG_NAME"

rm -f "$tmpfile"

echo "Installed $PKG_NAME to $EZOS_DIR/$PKG_NAME"
