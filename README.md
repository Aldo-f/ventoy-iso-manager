# Ventoy USB Setup Scripts

A collection of scripts and configuration files to set up and manage a Ventoy USB drive with organized ISOs, persistence support, and automated downloads.

## Features

- **Flat ISO structure**: All ISOs directly in numbered folders for easy Ventoy navigation
- **Persistence support**: Pre-configured persistence images for Ubuntu, Fedora, and Manjaro families
- **Interactive ISO downloader**: Download verified ISOs directly to the correct folders
- **Local web interface**: View all ISOs and persistence status via a local web server
- **Space checking**: Verify USB has enough space before downloading

## Directory Structure

```
ventoy-setup/
├── scripts/
│   ├── downloadIsos.sh          # Interactive ISO downloader
│   ├── testDownloads.sh         # Test all download URLs
│   ├── createPersistence.sh     # Create persistence images
│   ├── startIndex.sh            # Start local web server
│   ├── index.html               # Web interface
│   └── README.md                # Scripts documentation
├── ventoy/
│   └── ventoy.json              # Ventoy configuration with persistence + tree-view
├── docs/
│   ├── TAILS_PERSISTENCE.md     # Tails persistence guide
│   └── SYSTEM_TOOLS.md          # System tools documentation
├── 01-Linux/                    # All Linux ISOs
├── 02-Windows/                  # Windows ISOs
├── 03-Tools/                    # Recovery tool ISOs (GParted, Clonezilla, Rescuezilla)
├── 04-ToSort/                   # Empty, for new unsorted ISOs
└── persistence/                 # Persistence images
```

## Quick Start

1. **Set up Ventoy USB**:
   - Download and install Ventoy on your USB drive
   - Copy the contents of this repo to the USB root

2. **Download ISOs**:
   ```bash
   sudo bash scripts/downloadIsos.sh
   ```

3. **Create persistence images** (optional):
   ```bash
   sudo bash scripts/createPersistence.sh
   ```

4. **View web interface**:
   ```bash
   bash scripts/startIndex.sh
   # Open http://localhost:8080 in your browser
   ```

## Configuration

### Ventoy Persistence
Edit `ventoy/ventoy.json` to configure persistence for specific ISOs. Each entry requires:
- `alias`: Display name
- `iso`: Path to ISO file (relative to USB root)
- `file`: Path to persistence image

### Download Categories
Edit `scripts/downloadIsos.sh` to add new ISOs. Each entry follows:
```bash
add_item "Category" "Name" \
    "https://download-url.iso" \
    "01-Linux"
```
Use `01-Linux` for Linux distros, `02-Windows` for Windows, `03-Tools` for tools, or `04-ToSort` for unsorted ISOs.

## Space Checking

The download script includes automatic space checking:
- Retrieves exact ISO size via HTTP HEAD request
- Compares with available space on USB drive
- Warns and asks for confirmation if space is insufficient

## Requirements

- Ventoy installed on USB drive
- Linux system with bash
- Required tools: `wget`, `curl`, `python3` (for web server)
- `sudo` for creating persistence images

## License

MIT License - Feel free to modify and distribute.
