#!/bin/bash
# Interactive ISO Downloader - whiptail interface
# Run: sudo bash scripts/downloadIsos.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/../OS"

# Format: CATEGORY|NAME|URL|PATH
declare -a ITEMS

add_item() {
    ITEMS+=("$1|$2|$3|$4")
}

# ============================================================
# Ubuntu Family
# ============================================================
add_item "Ubuntu" "Ubuntu 24.04 LTS" "https://releases.ubuntu.com/24.04/ubuntu-24.04.4-desktop-amd64.iso" "Linux/apt/Ubuntu"
add_item "Ubuntu" "Ubuntu 25.04" "https://releases.ubuntu.com/25.04/ubuntu-25.04-desktop-amd64.iso" "Linux/apt/Ubuntu"
add_item "Ubuntu" "Kubuntu 24.04 LTS" "https://cdimage.ubuntu.com/kubuntu/releases/24.04/release/kubuntu-24.04.4-desktop-amd64.iso" "Linux/apt/Ubuntu"
add_item "Ubuntu" "Lubuntu 24.04 LTS" "https://cdimage.ubuntu.com/lubuntu/releases/24.04/release/lubuntu-24.04.4-desktop-amd64.iso" "Linux/apt/Ubuntu"
add_item "Ubuntu" "Xubuntu 24.04 LTS" "https://cdimage.ubuntu.com/xubuntu/releases/24.04/release/xubuntu-24.04.4-desktop-amd64.iso" "Linux/apt/Ubuntu"
add_item "Ubuntu" "Ubuntu MATE 24.04" "https://cdimage.ubuntu.com/ubuntu-mate/releases/24.04/release/ubuntu-mate-24.04.4-desktop-amd64.iso" "Linux/apt/Ubuntu"
add_item "Ubuntu" "Ubuntu Budgie 24.04" "https://cdimage.ubuntu.com/ubuntu-budgie/releases/24.04/release/ubuntu-budgie-24.04.4-desktop-amd64.iso" "Linux/apt/Ubuntu"

# ============================================================
# Debian
# ============================================================
add_item "Debian" "Debian 12 Netinst" "https://cdimage.debian.org/cdimage/archive/12.11.0/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso" "Linux/apt/Debian"

# ============================================================
# Other Distros
# ============================================================
add_item "Other Distros" "Linux Mint 22.1" "https://mirror.metanet.ch/linuxmint-cd/stable/22.1/linuxmint-22.1-cinnamon-64bit.iso" "Linux/apt/LinuxMint"
add_item "Other Distros" "Pop!_OS 24.04" "https://iso.pop-os.org/24.04/amd64/generic/23/pop-os_24.04_amd64_generic_23.iso" "Linux/apt/PopOS"
add_item "Other Distros" "Manjaro KDE 26.0.2" "https://download.manjaro.org/kde/26.0.2/manjaro-kde-26.0.2-260206-linux618.iso" "Linux/pacman/Manjaro"

# ============================================================
# Security
# ============================================================
add_item "Security" "Parrot Security 7.1" "https://bunny.deb.parrot.sh/parrot/iso/7.1/Parrot-security-7.1_amd64.iso" "Linux/apt/Parrot"
add_item "Security" "Parrot Home 7.1" "https://bunny.deb.parrot.sh/parrot/iso/7.1/Parrot-home-7.1_amd64.iso" "Linux/apt/Parrot"

# ============================================================
# Fedora
# ============================================================
add_item "Fedora" "Fedora 41 Workstation" "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Workstation/x86_64/iso/Fedora-Workstation-41-1.4.x86_64.iso" "Linux/dnf/Fedora"

# ============================================================
# Enterprise
# ============================================================
add_item "Enterprise" "Rocky Linux 9.7" "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.7-x86_64-dvd.iso" "Linux/dnf/Rocky"
add_item "Enterprise" "AlmaLinux 9" "https://repo.almalinux.org/almalinux/9/isos/x86_64/AlmaLinux-9-latest-x86_64-dvd.iso" "Linux/dnf/Alma"
add_item "Enterprise" "openSUSE Leap 15.6" "https://download.opensuse.org/distribution/leap/15.6/iso/openSUSE-Leap-15.6-DVD-x86_64-Media.iso" "Linux/zypper/openSUSE"
add_item "Enterprise" "openSUSE Tumbleweed" "https://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Current.iso" "Linux/zypper/openSUSE"

# ============================================================
# Arch
# ============================================================
add_item "Arch" "Arch Linux" "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso" "Linux/pacman/Arch"

# ============================================================
# Tools
# ============================================================
add_item "Tools" "GParted Live" "https://sourceforge.net/projects/gparted/files/gparted-live-stable/1.6.0-1/gparted-live-1.6.0-1-amd64.iso" "Linux/Tools"
add_item "Tools" "Clonezilla Live" "https://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/3.1.2-22/clonezilla-live-3.1.2-22-amd64.iso" "Linux/Tools"
add_item "Tools" "Rescuezilla" "https://sourceforge.net/projects/rescuezilla/files/rescuezilla/stable/2.5/rescuezilla-2.5-64bit.jammy.iso" "Linux/Tools"

# ============================================================
# Lightweight
# ============================================================
add_item "Lightweight" "antiX 23.2" "https://sourceforge.net/projects/antix-linux/files/Final/antiX-23.2/antiX-23.2_x64-full.iso" "Linux/Other/antiX"

# ============================================================
# Functions
# ============================================================

get_remote_file_size() {
    local url="$1"
    local size_bytes
    size_bytes=$(curl -sI -L "$url" 2>/dev/null | grep -i "Content-Length" | tail -1 | tr -d '\r' | awk '{print $2}')
    [[ -z "$size_bytes" || "$size_bytes" == "0" ]] && echo "-1" || echo "$size_bytes"
}

bytes_to_human() {
    local bytes=$1
    [ "$bytes" -eq -1 ] && echo "Unknown" && return
    local units=("B" "KB" "MB" "GB" "TB")
    local unit_index=0
    local size=$bytes
    while [ "$size" -gt 1024 ] && [ "$unit_index" -lt 4 ]; do
        size=$((size / 1024))
        ((unit_index++))
    done
    echo "${size} ${units[$unit_index]}"
}

get_total_size() {
    local total=0
    for idx in "$@"; do
        local item="${ITEMS[$((idx-1))]}"
        IFS='|' read -r category name url path <<< "$item"
        local size=$(get_remote_file_size "$url")
        [ "$size" -gt 0 ] 2>/dev/null && total=$((total + size))
    done
    echo $total
}

check_existing() {
    local idx=$1
    local item="${ITEMS[$((idx-1))]}"
    IFS='|' read -r category name url path <<< "$item"
    local filename
    filename=$(basename "$url")
    [ -f "$TARGET_DIR/$path/$filename" ] && echo "true" || echo "false"
}

show_selection_menu() {
    local menu_items=()
    local current_cat=""
    local idx=1
    
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r category name url path <<< "$item"
        
        if [ "$cat" != "$current_cat" ]; then
            current_cat="$cat"
            menu_items+=("" "━━━ $cat ━━━")
        fi
        
        local exists=$(check_existing "$idx")
        local status="[ ]"
        [ "$exists" = "true" ] && status="[✓]"
        
        menu_items+=("$idx" "$status $name ($path)")
        ((idx++))
    done
    
    # Use whiptail checklist
    local selected
    selected=$(whiptail --title "Ventoy ISO Downloader" \
        --backtitle "Use SPACE to toggle, TAB to navigate buttons" \
        --checklist "Select ISO's to download ( SPACE = toggle, ENTER = confirm )" \
        30 80 20 \
        "${menu_items[@]}" \
        3>&1 1>&2 2>&3)
    
    echo "$selected"
}

download_selected() {
    local selected=("$@")
    
    if [ ${#selected[@]} -eq 0 ] || [ -z "${selected[0]}" ]; then
        whiptail --title "Error" --msgbox "No items selected!" 8 40
        return
    fi
    
    # Calculate total size
    local total_size
    total_size=$(get_total_size "${selected[@]}")
    local total_human
    total_human=$(bytes_to_human "$total_size")
    
    local available_bytes
    available_bytes=$(df -B1 "$TARGET_DIR" | awk 'NR==2 {print $4}')
    local available_human
    available_human=$(bytes_to_human "$available_bytes")
    
    local item_list=""
    for idx in "${selected[@]}"; do
        local item="${ITEMS[$((idx-1))]}"
        IFS='|' read -r category name url path <<< "$item"
        item_list="$item_list$name\n"
    done
    
    # Show summary
    if ! whiptail --title "Download Summary" \
        --yesno "Selected: ${#selected[@]} items\nTotal size: $total_human\nAvailable: $available_human\n\n$item_list\n\nStart download?" \
        25 60; then
        return
    fi
    
    # Check space
    if [ "$total_size" -gt 0 ] && [ "$available_bytes" -lt "$total_size" ]; then
        local needed=$((total_size - available_bytes))
        local needed_human
        needed_human=$(bytes_to_human "$needed")
        whiptail --title "Error" --msgbox "Not enough space! Need ${needed_human} more." 10 40
        return
    fi
    
    # Download loop
    local total=${#selected[@]}
    local idx=1
    local log_file="/tmp/ventoy_download_$$.log"
    
    > "$log_file"
    
    for global_idx in "${selected[@]}"; do
        local item="${ITEMS[$((global_idx-1))]}"
        IFS='|' read -r category name url path <<< "$item"
        
        local filename
        filename=$(basename "$url")
        
        mkdir -p "$TARGET_DIR/$path"
        
        if [ -f "$TARGET_DIR/$path/$filename" ]; then
            echo "✓ Already exists: $name" >> "$log_file"
            continue
        fi
        
        echo "[$idx/$total] Downloading: $name" >> "$log_file"
        
        wget -O "$TARGET_DIR/$path/$filename" --continue "$url" >> "$log_file" 2>&1
        
        if [ -f "$TARGET_DIR/$path/$filename" ]; then
            echo "✓ Success: $name" >> "$log_file"
        else
            echo "✗ Failed: $name" >> "$log_file"
            rm -f "$TARGET_DIR/$path/$filename"
        fi
        
        ((idx++))
    done
    
    whiptail --title "Download Complete" --textbox "$log_file" 25 80
    rm -f "$log_file"
}

# Check for required tools
if ! command -v wget &> /dev/null; then
    echo "Error: wget required"
    exit 1
fi
if ! command -v curl &> /dev/null; then
    echo "Error: curl required"
    exit 1
fi
if ! command -v whiptail &> /dev/null; then
    echo "Error: whiptail required. Install: sudo apt install whiptail"
    exit 1
fi

# Main loop
while true; do
    selected=$(show_selection_menu)
    
    if [ $? -ne 0 ]; then
        exit 0
    fi
    
    # Parse selected items (whiptail returns space-separated indices)
    declare -a selected_indices
    for item in $selected; do
        selected_indices+=("$item")
    done
    
    if [ ${#selected_indices[@]} -gt 0 ]; then
        download_selected "${selected_indices[@]}"
    fi
done