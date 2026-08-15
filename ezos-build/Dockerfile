FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget curl nano ca-certificates

RUN echo 'NAME="EZOS"' > /etc/os-release && \
    echo 'ID=ezos' >> /etc/os-release && \
    echo 'VERSION_ID="3.0"' >> /etc/os-release && \
    echo 'PRETTY_NAME="EZOS 3.0 (Debian-based)"' >> /etc/os-release

RUN mkdir -p /usr/local/bin /var/lib/ezpkg && \
    printf '#!/bin/sh\nREPO="https://raw.githubusercontent.com/mrzgamingv20-cyber/ezos-repo/main"\nDB="/var/lib/ezpkg/installed.txt"\nmkdir -p "$(dirname "$DB")"\ncase "$1" in\n  install)\n    pkg="$2"\n    if wget -q --spider "$REPO/packages/$pkg.tar.gz" 2>/dev/null; then\n      wget -q "$REPO/packages/$pkg.tar.gz" -O "/tmp/$pkg.tar.gz"\n      tar -xzf "/tmp/$pkg.tar.gz" -C /\n      echo "$pkg" >> "$DB"\n      echo "$pkg installed (from EZOS repo)."\n    else\n      apt-get install -y "$pkg" && echo "$pkg installed (from Debian repo)."\n    fi\n    ;;\n  remove)\n    apt-get remove -y "$2" 2>/dev/null\n    sed -i "/^$2$/d" "$DB" 2>/dev/null\n    echo "$2 removed."\n    ;;\n  search)\n    apt-cache search "$2"\n    ;;\n  update)\n    apt-get update\n    ;;\n  upgrade)\n    apt-get upgrade -y\n    ;;\n  list)\n    echo "--- EZOS repo packages ---"\n    cat "$DB" 2>/dev/null || echo "(none)"\n    ;;\n  *)\n    echo "Usage: ezpkg [install|remove|search|update|upgrade|list] <package>"\n    ;;\nesac\n' > /usr/local/bin/ezpkg && \
    chmod +x /usr/local/bin/ezpkg
