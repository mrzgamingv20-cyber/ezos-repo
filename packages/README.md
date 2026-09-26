# EZOS Package Repository

## Structure

```
packages/
├── index.json          ← Package registry (name → description)
├── <package>.tar.gz    ← Package files (tarball with ./usr/local/bin/<pkg>)
└── build-packages.sh   ← Build .tar.gz from .deb files
```

## Creating a new package

### 1. Prepare the package binary

The `.tar.gz` must contain the binary at `./usr/local/bin/<package>`:

```
mypackage/
└── usr/
    └── local/
        └── bin/
            └── mypackage   ← executable binary
```

### 2. Create the tarball

```bash
cd mypackage
tar -czf ../mypackage.tar.gz ./
```

### 3. Add to index.json

```json
{
  "mypackage": "Description of your package"
}
```

### 4. Upload to your GitHub repo

```
your-repo/
└── packages/
    ├── index.json
    └── mypackage.tar.gz
```

## Adding a repo to EZOS

```bash
ezpkg repo add https://github.com/username/your-repo
```

This will automatically detect packages and ask for installation confirmation.

## Building from .deb files

```bash
cd packages
bash build-packages.sh    # Build all packages
```

Edit `build-packages.sh` to add/remove packages. Each package maps to a Debian `.deb` file from deb.debian.org.
