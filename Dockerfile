# EZOS Dockerfile (root-level convenience)
# Usage: docker build -t ezos:local .
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    EZOS_VERSION=3.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget curl nano ca-certificates \
        fastfetch && \
    rm -rf /var/lib/apt/lists/*

# EZOS branding
RUN echo "NAME=\"EZOS\"" > /etc/os-release && \
    echo "ID=ezos" >> /etc/os-release && \
    echo "VERSION_ID=\"${EZOS_VERSION}\"" >> /etc/os-release && \
    echo 'PRETTY_NAME="EZOS ${EZOS_VERSION} (Debian-based)"' >> /etc/os-release

# Copy MOTD and profile
COPY ezos-build/motd /etc/motd
RUN echo "cat /etc/motd" >> /etc/profile

# Copy fastfetch config
RUN mkdir -p /root/.config/fastfetch
COPY ezos-build/fastfetch-config/config.jsonc /root/.config/fastfetch/config.jsonc
RUN echo "alias fastfetch='fastfetch -c /root/.config/fastfetch/config.jsonc'" >> /root/.bashrc

# Copy ezpkg and tools
RUN mkdir -p /usr/local/bin /var/lib/ezpkg /var/cache/ezpkg
COPY ezos-build/scripts/ezpkg /usr/local/bin/ezpkg
COPY ezos-build/scripts/ezinfo /usr/local/bin/ezinfo
COPY ezos-build/scripts/ezupdate /usr/local/bin/ezupdate
COPY ezos-build/scripts/setup.sh /usr/local/bin/setup-ezos
RUN chmod +x /usr/local/bin/ezpkg /usr/local/bin/ezinfo /usr/local/bin/ezupdate /usr/local/bin/setup-ezos

# Initialize installed list
RUN echo "ezinfo" > /var/lib/ezpkg/installed.txt

CMD ["/bin/bash"]
