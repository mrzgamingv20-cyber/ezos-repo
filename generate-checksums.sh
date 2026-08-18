#!/bin/bash
# generate-checksums.sh - Generate SHA256 checksums untuk semua package files
# Usage: ./generate-checksums.sh
# Output: CHECKSUMS.sha256 dan packages/CHECKSUMS.sha256

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_DIR="$SCRIPT_DIR/packages"
CHECKSUM_FILE="$PACKAGES_DIR/CHECKSUMS.sha256"

# Color codes untuk Termux
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}  EZOS Package Checksum Generator${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Check if packages directory exists
if [ ! -d "$PACKAGES_DIR" ]; then
    echo -e "${RED}❌ Error: Packages directory not found at $PACKAGES_DIR${NC}"
    exit 1
fi

# Check if sha256sum is available
if ! command -v sha256sum &> /dev/null; then
    echo -e "${RED}❌ Error: sha256sum command not found. Install it with:${NC}"
    echo -e "${YELLOW}  pkg install coreutils${NC}"
    exit 1
fi

echo -e "${BLUE}📂 Scanning packages directory...${NC}"
echo ""

# Create/Clear checksum file
> "$CHECKSUM_FILE"

PKG_COUNT=0
TOTAL_SIZE=0

# Find all .tar.gz files in packages directory
while IFS= read -r -d '' pkg_file; do
    PKG_NAME=$(basename "$pkg_file")
    PKG_SIZE=$(du -h "$pkg_file" | cut -f1)
    
    echo -ne "${YELLOW}⏳ Processing: $PKG_NAME (${PKG_SIZE})...${NC}"
    
    # Generate SHA256
    CHECKSUM=$(sha256sum "$pkg_file" | cut -d' ' -f1)
    
    # Add to checksum file (format: CHECKSUM *filename)
    echo "$CHECKSUM  $PKG_NAME" >> "$CHECKSUM_FILE"
    
    echo -e "\r${GREEN}✓ Generated: $PKG_NAME${NC}                "
    
    PKG_COUNT=$((PKG_COUNT + 1))
    
done < <(find "$PACKAGES_DIR" -maxdepth 1 -name "*.tar.gz" -print0)

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✓ Done! Generated checksums for ${PKG_COUNT} package(s)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Display generated checksums
echo -e "${YELLOW}📋 Checksums (${CHECKSUM_FILE}):${NC}"
echo ""
cat "$CHECKSUM_FILE"
echo ""

# Create root-level checksum file as well (for releases)
cp "$CHECKSUM_FILE" "$SCRIPT_DIR/CHECKSUMS.sha256"
echo -e "${GREEN}✓ Copied to: $SCRIPT_DIR/CHECKSUMS.sha256${NC}"
echo ""

echo -e "${BLUE}📝 Next steps:${NC}"
echo -e "  1. Commit checksums: ${YELLOW}git add CHECKSUMS.sha256 packages/CHECKSUMS.sha256${NC}"
echo -e "  2. Push changes: ${YELLOW}git commit -m 'Add SHA256 checksums' && git push${NC}"
echo -e "  3. Upload to release assets when creating new release"
echo ""
