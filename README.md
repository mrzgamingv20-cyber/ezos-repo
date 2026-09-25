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

📦 Package Manager

EZOS uses `ezpkg` as its custom package manager. It first checks the EZOS repository, then falls back to Debian apt.

```bash
ezpkg install <package>     # Install a package
ezpkg remove <package>      # Remove a package
ezpkg search <query>        # Search Debian repos
ezpkg update                # Update apt lists
ezpkg upgrade               # Upgrade all packages
ezpkg list                  # List installed packages
```

Available EZOS packages are listed in `packages/index.json`.

Building packages from .deb:

```bash
cd packages
bash build-packages.sh wget nano git    # Build specific packages
bash build-packages.sh                  # Build all packages
```

🔧 Development

Build the Docker image locally:

```bash
docker build -f ezos-build/Dockerfile -t ezos:local .
```

👨‍💻 Contributors

- [@mrzgamingv20-cyber](https://github.com/mrzgamingv20-cyber) — Creator & developer

📜 License

MIT License — see [LICENSE](LICENSE).

---

<p align="center">Made with 🐧, ☕, and a questionable amount of code.</p>
