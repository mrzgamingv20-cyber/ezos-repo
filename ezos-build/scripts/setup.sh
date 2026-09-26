#!/bin/sh
# setup.sh - Complete EZOS system setup
# Run on first boot to configure everything
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${CYAN}━━━ EZOS Setup ━━━${NC}"

# Setup /etc/os-release
if [ ! -f /etc/os-release ]; then
    echo -e "${YELLOW}[1/5]${NC} Setting up os-release..."
    echo 'NAME="EZOS"' > /etc/os-release
    echo 'ID=ezos' >> /etc/os-release
    echo 'VERSION_ID="3.0"' >> /etc/os-release
    echo 'PRETTY_NAME="EZOS 3.0 (Debian-based)"' >> /etc/os-release
fi

# Setup MOTD
if [ ! -f /etc/motd ]; then
    echo -e "${YELLOW}[2/5]${NC} Setting up MOTD..."
    cp /usr/local/share/ezos/motd /etc/motd 2>/dev/null || true
fi

# Setup fastfetch alias
if ! grep -q "fastfetch" /root/.bashrc 2>/dev/null; then
    echo -e "${YELLOW}[3/5]${NC} Setting up fastfetch..."
    mkdir -p /root/.config/fastfetch
    cat > /root/.config/fastfetch/config.jsonc << 'EOF'
{
  "logo": {
    "type": "file",
    "source": "/etc/motd"
  },
  "modules": [
    {"type": "custom", "format": "OS: EZOS 3.0 (Debian-based) aarch64"},
    "host", "kernel", "uptime", "packages", "shell", "memory", "disk"
  ]
}
EOF
    echo "alias fastfetch='fastfetch -c /root/.config/fastfetch/config.jsonc'" >> /root/.bashrc
fi

# Setup ezpkg
if [ ! -f /usr/local/bin/ezpkg ]; then
    echo -e "${YELLOW}[4/5]${NC} Setting up ezpkg..."
    mkdir -p /usr/local/bin /var/lib/ezpkg /var/cache/ezpkg
    echo "ezinfo" > /var/lib/ezpkg/installed.txt
fi

# Setup profile
if ! grep -q "cat /etc/motd" /etc/profile 2>/dev/null; then
    echo -e "${YELLOW}[5/5]${NC} Setting up profile..."
    echo "cat /etc/motd" >> /etc/profile
fi

echo -e "${GREEN}[✓]${NC} EZOS setup complete!"
echo -e "  ${CYAN}Run 'fastfetch' to see system info.${NC}"
echo -e "  ${CYAN}Run 'ezpkg repo add <url>' to add packages.${NC}"
