![EZOS Logo](./assets/logoezos.jpg)

🐧 EZOS

EZOS is a standalone Linux distribution built from scratch to run on Android through Termux + `proot-distro`.

Built on top of Debian "bookworm-slim", EZOS comes with its own branding, a custom package manager (`ezpkg`), and a collection of exclusive tools designed specifically for EZOS.

✨ Features

- 🐧 **Base**: Debian bookworm-slim (aarch64)
- 📦 **Package Manager**: `ezpkg` — EZOS repo packages or Debian apt fallback
- 🛠️ **Tools**: `ezinfo`, `ezupdate`, `fastfetch`
- 🎨 **Branding**: Custom ASCII logo, MOTD, `/etc/os-release`, fastfetch config
- 📦 **OCI Image**: Distributed via [GHCR](https://ghcr.io/mrzgamingv20-cyber/ezos:latest)
- 📱 **Android Ready**: Runs directly on Android via Termux

📥 Installation

```bash
pkg update -y
pkg install proot-distro -y
proot-distro install ghcr.io/mrzgamingv20-cyber/ezos:latest
proot-distro login ezos
```

📦 Package Manager — `ezpkg`

All-in-one package manager. Install from EZOS repos or add external repos.

```bash
# Core commands
ezpkg install <pkg>          # Install with confirmation
ezpkg install-yes <pkg>      # Install without confirmation
ezpkg remove <pkg>           # Remove from ezpkg repos
ezpkg upgrade                # Upgrade all packages
ezpkg clean                  # Clear package cache
ezpkg version                # Show EZOS version

# Search & info
ezpkg search <query>         # Search across all repos
ezpkg info <pkg>             # Show package details
ezpkg list-remote            # List all available packages
ezpkg list                   # Show installed packages
ezpkg installed              # Show installed packages with checkmarks

# Repository management
ezpkg repo add <url>         # Add repo + auto-install package
ezpkg repo remove <url>      # Remove extra repo
ezpkg repo list              # Show active repos
ezpkg repo update            # Refresh repo availability
ezpkg repo count             # Count packages across repos
```

Available EZOS packages are listed in `packages/index.json`.

Building packages from .deb:

```bash
cd packages
bash build-packages.sh                # Build all packages
bash checksums.sh generate           # Generate checksums
bash checksums.sh verify             # Verify checksums
bash generate-index.sh               # Auto-generate index.json
```

🔧 Development

Build the Docker image locally:

```bash
make build                # Build EZOS Docker image
make build-push           # Build and push to GHCR
make run                  # Run EZOS container
make package              # Build all .tar.gz packages
make verify               # Verify package checksums
make list-remote          # List available packages
make setup-ezos           # Run first-boot setup
make clean                # Remove generated files
```

👨‍💻 Contributors

- [@mrzgamingv20-cyber](https://github.com/mrzgamingv20-cyber) — Creator & developer

📜 License

MIT License — see [LICENSE](LICENSE).

---

<p align="center">Made with 🐧, ☕, and a questionable amount of code.</p>
