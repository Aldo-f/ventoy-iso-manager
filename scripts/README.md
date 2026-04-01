# Ventoy USB Scripts

All scripts should be run from the USB root directory or with the script path.

## Scripts Overview

### 1. startIndex.sh
Starts a local web server to view the index.html page.
```bash
sudo bash scripts/startIndex.sh
```
Then open: http://localhost:8080/index.html

### 2. createPersistence.sh
Creates persistence images (8GB each) for live USB sessions.
```bash
sudo bash scripts/createPersistence.sh
```
Creates: ubuntu-casper-rw.img, fedora-casper-rw.img, manjaro-casper-rw.img

### 3. downloadIsos.sh
Interactive script to download ISO files from various distributions.
```bash
sudo bash scripts/downloadIsos.sh
```
Select distributions by number (space-separated).

### 4. CreatePersistentImg.sh
Low-level script to create a single persistence image.
```bash
sudo bash scripts/CreatePersistentImg.sh -s 8192 -t ext4 -l casper-rw -o persistence/my-persist.img
```

## Usage

1. **View index**: Start web server and open index.html
2. **Download ISOs**: Run downloadIsos.sh and select distro's
3. **Create persistence**: Run createPersistence.sh (once)
4. **Update ventoy.json**: Edit ventoy/ventoy.json as needed