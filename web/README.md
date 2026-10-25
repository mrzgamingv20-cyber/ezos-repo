# EZOS 3.0 — Web Edition

Part of the [EZOS repo](https://github.com/mrzgamingv20-cyber/ezos-repo) · **Live:** https://mrzgamingv20-cyber.github.io/ezos-repo/

A tiny operating-system experience that runs entirely in a **single HTML file**.
No build step, no server, no dependencies — just open it in a browser.

## Run it

**Option 1 — direct file**
```
open index.html
```
(double-click the file, or drag it into your browser)

**Option 2 — local server** (recommended on mobile/Termux)
```bash
cd ezos-web
python3 -m http.server 8000
```
Then visit `http://localhost:8000`.

## What's inside

| App | Description |
|-----|-------------|
| Terminal | `ezsh` shell with 20+ commands, history, pipes-to-file (`echo hi > file.txt`) |
| Files | Browse the virtual filesystem, create/delete folders & files |
| Store | Package browser — install/remove packages from `ezos-repo` |
| Editor | Text editor with Ctrl+S save, path bar, status line |
| Calculator | Keyboard + touch friendly |
| Paint | Draw, erase, save PNG into `/home/user/Pictures` |
| Snake | Classic snake with persistent high score |
| Settings | 4 themes, 6 accent colors, 5 wallpapers, sound, reset |
| System Monitor | Live uptime, storage and process list (open via `htop`) |
| Preview | Image viewer for drawings saved from Paint |
| About | System info & shortcuts |

## Terminal cheat sheet

```
help            ls        cd         pwd        cat
mkdir           touch     rm [-r]    echo       tree
neofetch        date      whoami     uname -a   open <app>
theme <name>    wallpaper <name>    history    reboot    exit
```

Shortcuts: `Ctrl+Alt+T` terminal · `Ctrl+S` save (Editor) · `Esc` close menus.

## Package manager (`ezpkg`)

Packages are served by the [ezos-repo](https://github.com/mrzgamingv20-cyber/ezos-repo)
package repository. The index is fetched from GitHub at runtime (with an offline fallback).

```
ezpkg list-remote          # available packages
ezpkg search json          # search name/description
ezpkg info jq              # package details + download URL
ezpkg install fastfetch    # install
ezpkg install htop jq      # multiple
ezpkg list                 # installed
ezpkg remove jq            # uninstall
ezpkg update               # refresh index
```

Installed packages unlock terminal commands:

| Package | Command |
|---------|---------|
| fastfetch | `fastfetch` — system info |
| htop | `htop` — opens System Monitor |
| jq | `jq . file.json` — JSON pretty printer |
| curl | `curl <url>` — fetch text (CORS permitting) |
| dig | `dig <domain>` — DNS lookup via dns.google |
| ezupdate | `ezupdate` — check latest ezos-repo commit |
| ezinfo | `ezinfo` — system info + credits |
| hello | `hello` |
| ssh, scp, sftp, rsync, tcpdump, … | simulated (native binaries can't run in a browser) |

Install manifests are written to `/var/lib/ezpkg/` inside the virtual filesystem,
so you can inspect them with Files or `cat`.

## Notes

- Everything you create is stored in **localStorage**, so it survives reloads.
- Use **Settings → Reset EZOS** to wipe all data.
- Fonts load from Google Fonts when online; the OS works offline with fallback fonts.
- Tested layout: desktop and mobile (windows open maximized on small screens).
