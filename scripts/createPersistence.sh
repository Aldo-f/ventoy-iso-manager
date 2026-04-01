#!/bin/bash
# Ventoy Persistence Images Creator
# Run this file as: sudo bash scripts/createPersistence.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

echo "=== Ventoy Persistence Images Creator ==="
echo ""

# Check if we are root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root/sudo!"
    exit 1
fi

echo "1. Ubuntu/Mint/PopOS/Debian/Kali persistence (8GB)..."
bash scripts/CreatePersistentImg.sh -s 8192 -t ext4 -l casper-rw -o persistence/ubuntu-casper-rw.img

echo ""
echo "2. Fedora/Rocky persistence (8GB)..."
bash scripts/CreatePersistentImg.sh -s 8192 -t ext4 -l fedora -o persistence/fedora-casper-rw.img

echo ""
echo "3. Manjaro/EndeavourOS persistence (8GB)..."
bash scripts/CreatePersistentImg.sh -s 8192 -t ext4 -l manjaro -o persistence/manjaro-casper-rw.img

echo ""
echo "=== Done! ==="
ls -lh persistence/