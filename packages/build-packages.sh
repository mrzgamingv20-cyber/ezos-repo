#!/bin/sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEB_DIR="$SCRIPT_DIR/.debs"
OUTPUT_DIR="$SCRIPT_DIR"
SITE="https://deb.debian.org/debian"

mkdir -p "$DEB_DIR"

build_one() {
    pkg="$1"
    deb_path="$2"
    deb_file="$DEB_DIR/$(basename "$deb_path")"
    deb_url="$SITE/$deb_path"

    if [ ! -f "$deb_file" ] || [ ! -s "$deb_file" ]; then
        echo "  [↓] Downloading $pkg..."
        wget -q -O "$deb_file" "$deb_url" 2>/dev/null || { echo "  [✗] Failed"; return 1; }
    fi

    tmpdir=$(mktemp -d)
    dpkg-deb -x "$deb_file" "$tmpdir" 2>/dev/null || { rm -rf "$tmpdir"; return 1; }
    (cd "$tmpdir" && tar -czf "$OUTPUT_DIR/${pkg}.tar.gz" ./ 2>/dev/null)
    rm -rf "$tmpdir"
    echo "  [✓] $pkg ($(du -h "$OUTPUT_DIR/${pkg}.tar.gz" 2>/dev/null | cut -f1))"
}

case "${1:-}" in
    "")
        build_one wget "pool/main/w/wget/wget_1.21.3-1+deb12u1_arm64.deb"
        build_one nano "pool/main/n/nano/nano_7.2-1+deb12u1_arm64.deb"
        build_one git "pool/main/g/git/git_2.39.5-0+deb12u3_arm64.deb"
        build_one iputils-ping "pool/main/i/iputils/iputils-ping_20221126-1+deb12u1_arm64.deb"
        build_one net-tools "pool/main/n/net-tools/net-tools_2.10-0.1+deb12u2_arm64.deb"
        build_one ca-certificates "pool/main/c/ca-certificates/ca-certificates_20230311+deb12u1_all.deb"
        build_one apt-utils "pool/main/a/apt/apt-utils_2.6.1_arm64.deb"
        build_one tree "pool/main/t/tree/tree_2.1.0-1_arm64.deb"
        build_one bat "pool/main/r/rust-bat/bat_0.22.1-4_arm64.deb"
        build_one btop "pool/main/b/btop/btop_1.2.13-1_arm64.deb"
        build_one ncdu "pool/main/n/ncdu/ncdu_1.18-0.2_arm64.deb"
        build_one fzf "pool/main/f/fzf/fzf_0.38.0-1+b1_arm64.deb"
        build_one ripgrep "pool/main/r/rust-ripgrep/ripgrep_13.0.0-4+b2_arm64.deb"
        build_one fd-find "pool/main/r/rust-fd-find/fd-find_8.6.0-3_arm64.deb"
        build_one bash-completion "pool/main/b/bash-completion/bash-completion_2.11-6_all.deb"
        build_one apt-transport-https "pool/main/a/apt/apt-transport-https_2.6.1_all.deb"
        build_one dnsutils "pool/main/b/bind9/dnsutils_9.18.49-1~deb12u1_all.deb"
        build_one iproute2 "pool/main/i/iproute2/iproute2_6.1.0-3_arm64.deb"
        build_one procps "pool/main/p/procps/procps_4.0.2-3_arm64.deb"
        build_one htop "pool/main/h/htop/htop_3.2.2-2_arm64.deb"
        build_one jq "pool/main/j/jq/jq_1.6-2.1+deb12u2_arm64.deb"
        build_one rsync "pool/main/r/rsync/rsync_3.2.7-1+deb12u6_arm64.deb"
        build_one tcpdump "pool/main/t/tcpdump/tcpdump_4.99.3-1_arm64.deb"
        build_one whois "pool/main/w/whois/whois_5.5.17_arm64.deb"
        build_one traceroute "pool/main/t/traceroute/traceroute_2.1.2-1_arm64.deb"
        build_one inetutils-traceroute "pool/main/i/inetutils/inetutils-traceroute_2.4-2+deb12u3_arm64.deb"
        build_one sysvinit-utils "pool/main/s/sysvinit/sysvinit-utils_3.06-4_arm64.deb"
        build_one unzip "pool/main/u/unzip/unzip_6.0-28_arm64.deb"
        build_one less "pool/main/l/less/less_590-2.1~deb12u2_arm64.deb"
        build_one patch "pool/main/p/patch/patch_2.7.6-7_arm64.deb"
        build_one python3 "pool/main/p/python3/python3_3.11.2-1+b1_arm64.deb"
        build_one openssh-client "pool/main/o/openssh/openssh-client_1.9.2p1-2+deb12u10_arm64.deb"
        build_one curl "pool/main/c/curl/curl_7.88.1-10+deb12u15_arm64.deb"
        build_one iputils-tracepath "pool/main/i/iputils/iputils-tracepath_20221126-1+deb12u1_arm64.deb"
        echo "All packages built."
        ;;
    *)
        echo "Usage: $0 (builds all packages)"
        echo "Edit the script to specify packages."
        ;;
esac

echo ""
echo "=== Done ==="
ls -lh "$OUTPUT_DIR"/*.tar.gz 2>/dev/null | grep -v "^total" | awk '{print "  " $9, $5}'
