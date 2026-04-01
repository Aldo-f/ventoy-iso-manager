#!/bin/bash
# Interactive ISO Downloader - Flat list with space toggle
# Run: sudo bash scripts/downloadIsos.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/../OS"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Format: CATEGORY|NAME|URL|PATH
declare -a ITEMS
declare -a SELECTED_INDICES

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

is_selected() {
    local idx=$1
    for sel in "${SELECTED_INDICES[@]}"; do
        [ "$sel" -eq "$idx" ] && return 0
    done
    return 1
}

toggle_selection() {
    local idx=$1
    if is_selected "$idx"; then
        local new_array=()
        for s in "${SELECTED_INDICES[@]}"; do
            [ "$s" -ne "$idx" ] && new_array+=("$s")
        done
        SELECTED_INDICES=("${new_array[@]}")
    else
        SELECTED_INDICES+=("$idx")
    fi
}

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
    for idx in "${SELECTED_INDICES[@]}"; do
        local item="${ITEMS[$((idx-1))]}"
        IFS='|' read -r cat name url path <<< "$item"
        local size=$(get_remote_file_size "$url")
        [ "$size" -gt 0 ] 2>/dev/null && total=$((total + size))
    done
    echo $total
}

print_list() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║         VENTOY ISO DOWNLOADER - Press SPACE to toggle    ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Press SPACE on number to toggle selection, D to download, C to clear, Q to quit"
    echo ""
    
    local current_cat=""
    local idx=1
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r cat name url path <<< "$item"
        
        # Print category header if changed
        if [ "$cat" != "$current_cat" ]; then
            echo -e "${YELLOW}━━━ ${cat} ━━━${NC}"
            current_cat="$cat"
        fi
        
        local filename
        filename=$(basename "$url")
        local exists=""
        [ -f "$TARGET_DIR/$path/$filename" ] && exists="${GREEN}✓${NC} "
        
        if is_selected "$idx"; then
            printf "  ${GREEN}[%2d]●${NC} %-35s ${exists}${YELLOW}→${NC} %s\n" "$idx" "$name" "$path"
        else
            printf "  ${GREEN}[%2d] ${NC} %-35s ${exists}${YELLOW}→${NC} %s\n" "$idx" "$name" "$path"
        fi
        
        ((idx++))
    done
    
    echo ""
    local total_size
    total_size=$(get_total_size)
    local total_human
    total_human=$(bytes_to_human "$total_size")
    echo -e "  ${CYAN}[D]${NC} Download (${GREEN}${#SELECTED_INDICES[@]}${NC} selected, ${YELLOW}${total_human}${NC})"
    echo -e "  ${CYAN}[C]${NC} Clear selection"
    echo -e "  ${CYAN}[Q]${NC} Quit"
    echo ""
}

download_selected() {
    if [ ${#SELECTED_INDICES[@]} -eq 0 ]; then
        echo -e "${RED}No items selected!${NC}"
        return
    fi
    
    echo -e "${CYAN}Calculating total size...${NC}"
    local total_size
    total_size=$(get_total_size)
    local total_human
    total_human=$(bytes_to_human "$total_size")
    
    local available_bytes
    available_bytes=$(df -B1 "$TARGET_DIR" | awk 'NR==2 {print $4}')
    local available_human
    available_human=$(bytes_to_human "$available_bytes")
    
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              DOWNLOAD SUMMARY                              ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Selected: ${GREEN}${#SELECTED_INDICES[@]} items${NC}"
    echo -e "Total size: ${YELLOW}${total_human}${NC}"
    echo -e "Available: ${YELLOW}${available_human}${NC}"
    echo ""
    
    if [ "$total_size" -gt 0 ] && [ "$available_bytes" -lt "$total_size" ]; then
        local needed=$((total_size - available_bytes))
        local needed_human
        needed_human=$(bytes_to_human "$needed")
        echo -e "${RED}✗ Not enough space! Need ${needed_human} more.${NC}"
        echo ""
        echo -e "Remove some items? (y/N)${NC}"
        read -r confirm
        [[ ! "$confirm" =~ ^[Yy] ]] && return
    fi
    
    echo -e "Start download? (y/N)${NC}"
    read -r confirm
    [[ ! "$confirm" =~ ^[Yy] ]] && return
    
    echo ""
    local idx=1
    local total=${#SELECTED_INDICES[@]}
    for global_idx in "${SELECTED_INDICES[@]}"; do
        local item="${ITEMS[$((global_idx-1))]}"
        IFS='|' read -r cat name url path <<< "$item"
        
        local filename
        filename=$(basename "$url")
        
        mkdir -p "$TARGET_DIR/$path"
        
        if [ -f "$TARGET_DIR/$path/$filename" ]; then
            echo -e "${GREEN}✓${NC} Already exists: $name"
            continue
        fi
        
        echo -e "${CYAN}[$idx/$total]${NC} Downloading: ${name}"
        
        local size_bytes
        size_bytes=$(get_remote_file_size "$url")
        [ "$size_bytes" -gt 0 ] && echo -e "  Size: $(bytes_to_human "$size_bytes")"
        
        wget -O "$TARGET_DIR/$path/$filename" --continue --progress=bar:force "$url" 2>&1 | tail -5
        
        if [ ${PIPESTATUS[0]} -eq 0 ] && [ -f "$TARGET_DIR/$path/$filename" ]; then
            echo -e "  ${GREEN}✓ Success${NC}"
        else
            echo -e "  ${RED}✗ Failed${NC}"
            rm -f "$TARGET_DIR/$path/$filename"
        fi
        
        ((idx++))
        echo ""
    done
    
    echo -e "${GREEN}Download complete!${NC}"
    SELECTED_INDICES=()
    echo "Press Enter to continue..."
    read
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

# Main loop
main_loop() {
    while true; do
        print_list
        echo -n "Choice: "
        read -r choice
        
        case "$choice" in
            q|Q)
                exit 0
                ;;
            d|D)
                download_selected
                ;;
            c|C)
                SELECTED_INDICES=()
                ;;
            *)
                # Check if it's a number to toggle
                if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#ITEMS[@]} ]; then
                    toggle_selection "$choice"
                fi
                ;;
        esac
    done
}

# Only run main loop if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_loop
fi