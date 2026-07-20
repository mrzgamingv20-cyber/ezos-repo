FROM arm64v8/busybox:musl

COPY motd.txt /etc/motd

RUN echo 'NAME="EZOS"' > /etc/os-release && \
    echo 'ID=ezos' >> /etc/os-release && \
    echo 'VERSION_ID="2.0"' >> /etc/os-release && \
    echo 'PRETTY_NAME="EZOS 2.0 (standalone)"' >> /etc/os-release && \
    echo 'cat /etc/motd' >> /etc/profile

RUN mkdir -p /usr/local/bin && \
    printf '#!/bin/sh\nREPO="https://raw.githubusercontent.com/mrzgamingv20-cyber/ezos-repo/main"\nDB="/var/lib/ezpkg/installed.txt"\nmkdir -p /var/lib/ezpkg\ncase "$1" in\n  install)\n    pkg="$2"\n    wget -q "$REPO/packages/$pkg.tar.gz" -O "/tmp/$pkg.tar.gz" || { echo "Not found"; exit 1; }\n    tar -xzf "/tmp/$pkg.tar.gz" -C /\n    echo "$pkg" >> "$DB"\n    echo "$pkg installed."\n    ;;\n  list)\n    cat "$DB" 2>/dev/null || echo "(none)"\n    ;;\n  *)\n    echo "Usage: ezpkg [install|list] <package>"\n    ;;\nesac\n' > /usr/local/bin/ezpkg && \
    chmod +x /usr/local/bin/ezpkg
