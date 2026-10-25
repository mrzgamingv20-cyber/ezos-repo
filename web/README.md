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
| Editor | Text editor with Ctrl+S save, path bar, status line |
| Calculator | Keyboard + touch friendly |
| Paint | Draw, erase, save PNG into `/home/user/Pictures` |
| Snake | Classic snake with persistent high score |
| Settings | 4 themes, 6 accent colors, 5 wallpapers, sound, reset |
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

## Notes

- Everything you create is stored in **localStorage**, so it survives reloads.
- Use **Settings → Reset EZOS** to wipe all data.
- Fonts load from Google Fonts when online; the OS works offline with fallback fonts.
- Tested layout: desktop and mobile (windows open maximized on small screens).
