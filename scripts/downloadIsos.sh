#!/bin/bash
# Interactive ISO Downloader - VERIFIED WORKING URLS ONLY
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

add_item() {
    ITEMS+=("$1|$2|$3|$4")
}

# ============================================================
# DESKTOP - Ubuntu Family (apt)
# ============================================================
add_item "Ubuntu" "Ubuntu 24.04 LTS" \
    "https://releases.ubuntu.com/24.04/ubuntu-24.04.4-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

add_item "Ubuntu" "Ubuntu 25.04" \
    "https://releases.ubuntu.com/25.04/ubuntu-25.04-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

add_item "Ubuntu" "Kubuntu 24.04 LTS" \
    "https://cdimage.ubuntu.com/kubuntu/releases/24.04/release/kubuntu-24.04.4-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

add_item "Ubuntu" "Lubuntu 24.04 LTS" \
    "https://cdimage.ubuntu.com/lubuntu/releases/24.04/release/lubuntu-24.04.4-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

add_item "Ubuntu" "Xubuntu 24.04 LTS" \
    "https://cdimage.ubuntu.com/xubuntu/releases/24.04/release/xubuntu-24.04.4-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

add_item "Ubuntu" "Ubuntu MATE 24.04" \
    "https://cdimage.ubuntu.com/ubuntu-mate/releases/24.04/release/ubuntu-mate-24.04.4-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

add_item "Ubuntu" "Ubuntu Budgie 24.04" \
    "https://cdimage.ubuntu.com/ubuntu-budgie/releases/24.04/release/ubuntu-budgie-24.04.4-desktop-amd64.iso" \
    "Linux/apt/Ubuntu"

# ============================================================
# DESKTOP - Debian (apt)
# ============================================================
add_item "Debian" "Debian 12 Netinst" \
    "https://cdimage.debian.org/cdimage/archive/12.11.0/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso" \
    "Linux/apt/Debian"

# ============================================================
# DESKTOP - Other Distros (apt)
# ============================================================
add_item "Other Distros" "Linux Mint 22.1 Cinnamon" \
    "https://mirror.metanet.ch/linuxmint-cd/stable/22.1/linuxmint-22.1-cinnamon-64bit.iso" \
    "Linux/apt/LinuxMint"

# ============================================================
# DESKTOP - Pop!_OS (apt)
# ============================================================
add_item "Pop!_OS" "Pop!_OS 24.04 LTS" \
    "https://iso.pop-os.org/24.04/amd64/generic/23/pop-os_24.04_amd64_generic_23.iso" \
    "Linux/apt/PopOS"

# ============================================================
# DESKTOP - Manjaro (pacman)
# ============================================================
add_item "Manjaro" "Manjaro KDE 26.0.2" \
    "https://download.manjaro.org/kde/26.0.2/manjaro-kde-26.0.2-260206-linux618.iso" \
    "Linux/pacman/Manjaro"



# ============================================================
# SECURITY - Penetration Testing (apt)
# ============================================================
add_item "Penetration Testing" "Parrot Security 6.2" \
    "https://download.parrot.sh/parrot/iso/6.2/Parrot-security-6.2_amd64.iso" \
    "Linux/apt/Parrot"

add_item "Penetration Testing" "Parrot Home 6.2" \
    "https://download.parrot.sh/parrot/iso/6.2/Parrot-home-6.2_amd64.iso" \
    "Linux/apt/Parrot"

# ============================================================
# DESKTOP - Fedora (dnf)
# ============================================================
add_item "Fedora" "Fedora 41 Workstation" \
    "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Workstation/x86_64/iso/Fedora-Workstation-41-1.4.x86_64.iso" \
    "Linux/dnf/Fedora"

# ============================================================
# DESKTOP - RPM Enterprise (dnf)
# ============================================================
add_item "RPM Enterprise" "Rocky Linux 9.7" \
    "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.7-x86_64-dvd.iso" \
    "Linux/dnf/Rocky"

add_item "RPM Enterprise" "AlmaLinux 9" \
    "https://repo.almalinux.org/almalinux/9/isos/x86_64/AlmaLinux-9-latest-x86_64-dvd.iso" \
    "Linux/dnf/Alma"

add_item "RPM Enterprise" "openSUSE Leap 15.6" \
    "https://download.opensuse.org/distribution/leap/15.6/iso/openSUSE-Leap-15.6-DVD-x86_64-Media.iso" \
    "Linux/zypper/openSUSE"

add_item "RPM Enterprise" "openSUSE Tumbleweed" \
    "https://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Current.iso" \
    "Linux/zypper/openSUSE"

# ============================================================
# DESKTOP - Arch-based (pacman)
# ============================================================
add_item "Arch-based" "Arch Linux" \
    "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso" \
    "Linux/pacman/Arch"

# ============================================================
# SYSTEM TOOLS - Disk Management
# ============================================================
add_item "Disk Tools" "GParted Live" \
    "https://sourceforge.net/projects/gparted/files/gparted-live-stable/1.6.0-1/gparted-live-1.6.0-1-amd64.iso" \
    "Linux/Tools"

add_item "Disk Tools" "Clonezilla Live" \
    "https://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/3.1.2-22/clonezilla-live-3.1.2-22-amd64.iso" \
    "Linux/Tools"

add_item "Disk Tools" "Rescuezilla" \
    "https://sourceforge.net/projects/rescuezilla/files/rescuezilla/stable/2.5/rescuezilla-2.5-64bit.jammy.iso" \
    "Linux/Tools"

# ============================================================
# LIGHTWEIGHT - Minimal Distros
# ============================================================
add_item "Lightweight" "antiX 23.2" \
    "https://sourceforge.net/projects/antix-linux/files/Final/antiX-23.2/antiX-23.2_x64-full.iso" \
    "Linux/Other/antiX"

# ============================================================
# Functions
# ============================================================

get_categories() {
    local -n cats_ref=$1
    cats_ref=()
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r cat name url path <<< "$item"
        local found=0
        for existing in "${cats_ref[@]}"; do
            if [ "$existing" = "$cat" ]; then
                found=1
                break
            fi
        done
        if [ $found -eq 0 ]; then
            cats_ref+=("$cat")
        fi
    done
}

print_main_menu() {
    local categories
    get_categories categories
    
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              VENTOY ISO DOWNLOADER (Verified)             ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Select a category:"
    echo ""
    
    local idx=1
    for cat in "${categories[@]}"; do
        local count=0
        for item in "${ITEMS[@]}"; do
            IFS='|' read -r c n u p <<< "$item"
            [ "$c" = "$cat" ] && ((count++))
        done
        
        printf "  ${GREEN}[%2d]${NC} %-20s ${YELLOW}(%d items)${NC}\n" "$idx" "$cat" "$count"
        ((idx++))
    done
    
    echo ""
    echo -e "  ${CYAN}[A]${NC} Download ALL"
    echo -e "  ${CYAN}[Q]${NC} Quit"
    echo ""
}

print_category_items() {
    local category="$1"
    
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║  ${YELLOW}$(printf '%-54s' "$category")${CYAN}║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo "Select items (comma-separated): 1,2,3"
    echo ""
    
    local idx=1
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r cat name url path <<< "$item"
        if [ "$cat" = "$category" ]; then
            local filename
            filename=$(basename "$url")
            if [ -f "$TARGET_DIR/$path/$filename" ]; then
                printf "  ${GREEN}[%2d]${NC} ${GREEN}✓${NC} %-38s ${YELLOW}→ ${path}/${NC}\n" "$idx" "$name"
            else
                printf "  ${GREEN}[%2d]${NC} %-40s ${YELLOW}→ ${path}/${NC}\n" "$idx" "$name"
            fi
        fi
        ((idx++))
    done
    echo ""
}

get_remote_file_size() {
    local url="$1"
    local size_bytes
    
    # Try to get size from Content-Length header
    size_bytes=$(curl -sI -L "$url" | grep -i "Content-Length" | tail -1 | tr -d '\r' | awk '{print $2}')
    
    if [[ -z "$size_bytes" || "$size_bytes" == "0" ]]; then
        # If Content-Length not available, return -1 to indicate unknown
        echo "-1"
    else
        echo "$size_bytes"
    fi
}

bytes_to_human() {
    local bytes=$1
    if [ "$bytes" -eq -1 ]; then
        echo "Unknown size"
        return
    fi
    
    local units=("B" "KB" "MB" "GB" "TB")
    local unit_index=0
    local size=$bytes
    
    while [ "$size" -gt 1024 ] && [ "$unit_index" -lt 4 ]; do
        size=$((size / 1024))
        ((unit_index++))
    done
    
    echo "${size} ${units[$unit_index]}"
}

check_available_space() {
    local target_dir="$1"
    local required_bytes=$2
    local name="$3"
    
    # Get available space in bytes
    local available_bytes
    available_bytes=$(df -B1 "$target_dir" | awk 'NR==2 {print $4}')
    
    # Convert to human readable for display
    local available_human
    available_human=$(bytes_to_human "$available_bytes")
    local required_human
    required_human=$(bytes_to_human "$required_bytes")
    
    echo -e "  ${YELLOW}Space required: ${required_human}${NC}"
    echo -e "  ${YELLOW}Space available: ${available_human}${NC}"
    
    if [ "$required_bytes" -eq -1 ]; then
        # Unknown size, ask for confirmation
        echo -e "  ${YELLOW}⚠ Could not determine ISO size. Continue? (y/N)${NC}"
        read -r confirm
        if [[ ! "$confirm" =~ ^[Yy] ]]; then
            echo -e "  ${RED}✗ Download cancelled${NC}"
            return 1
        fi
    elif [ "$available_bytes" -lt "$required_bytes" ]; then
        echo -e "  ${RED}✗ Not enough space! Need ${required_human} more${NC}"
        echo -e "  ${YELLOW}Continue anyway? (y/N)${NC}"
        read -r confirm
        if [[ ! "$confirm" =~ ^[Yy] ]]; then
            echo -e "  ${RED}✗ Download cancelled${NC}"
            return 1
        fi
    else
        local space_left=$((available_bytes - required_bytes))
        local space_left_human
        space_left_human=$(bytes_to_human "$space_left")
        echo -e "  ${GREEN}✓ Sufficient space (${space_left_human} will remain)${NC}"
    fi
    return 0
}

download_item() {
    local idx=$1
    local item="${ITEMS[$((idx-1))]}"
    IFS='|' read -r cat name url path <<< "$item"
    
    mkdir -p "$TARGET_DIR/$path"
    
    # Extract filename from URL
    local filename
    filename=$(basename "$url")
    
    # Check if file already exists
    if [ -f "$TARGET_DIR/$path/$filename" ]; then
        echo -e "${GREEN}✓${NC} Already exists: ${name}"
        echo -e "  ${YELLOW}→ ${path}/${filename}${NC}"
        return 0
    fi
    
    echo -e "${GREEN}↓${NC} Downloading: ${name}"
    echo -e "  Target: $TARGET_DIR/$path"
    
    # Get remote file size
    echo -e "  ${CYAN}Checking remote file size...${NC}"
    local size_bytes
    size_bytes=$(get_remote_file_size "$url")
    
    # Check available space
    if ! check_available_space "$TARGET_DIR/$path" "$size_bytes" "$name"; then
        return 1
    fi
    
    # Proceed with download
    wget -O "$TARGET_DIR/$path/$filename" --continue --progress=bar:force "$url" 2>&1 | tail -3
    
    if [ ${PIPESTATUS[0]} -eq 0 ] && [ -f "$TARGET_DIR/$path/$filename" ]; then
        echo -e "  ${GREEN}✓ Success${NC}"
        return 0
    else
        echo -e "  ${RED}✗ Failed${NC}"
        rm -f "$TARGET_DIR/$path/$filename"
        return 1
    fi
}

get_items_in_category() {
    local category="$1"
    local indices=()
    local idx=1
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r cat name url path <<< "$item"
        if [ "$cat" = "$category" ]; then
            indices+=($idx)
        fi
        ((idx++))
    done
    echo "${indices[@]}"
}

category_menu() {
    local category="$1"
    
    while true; do
        print_category_items "$category"
        echo -n "Selection (or B to go back): "
        read -r choice
        
        case "$choice" in
            b|B|"")
                return
                ;;
            *)
                local all_indices=($(get_items_in_category "$category"))
                IFS=',' read -ra SELECTIONS <<< "$choice"
                
                for sel in "${SELECTIONS[@]}"; do
                    sel=$(echo "$sel" | xargs)
                    if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -ge 1 ] && [ "$sel" -le "${#all_indices[@]}" ]; then
                        local real_idx="${all_indices[$((sel-1))]}"
                        download_item "$real_idx"
                        echo ""
                    fi
                done
                
                echo ""
                echo "Press Enter to continue..."
                read
                ;;
        esac
    done
}

download_all() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              DOWNLOADING ALL ISOs                          ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    local total=${#ITEMS[@]}
    local idx=1
    
    for item in "${ITEMS[@]}"; do
        echo -e "${CYAN}[$idx/$total]${NC}"
        download_item $idx
        echo ""
        ((idx++))
    done
    
    echo ""
    echo "Press Enter to continue..."
    read
}

# Check for required tools
if ! command -v wget &> /dev/null; then
    echo "Error: wget required. Install: sudo apt install wget"
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "Error: curl required. Install: sudo apt install curl"
    exit 1
fi

# Main loop
main_loop() {
    local categories
    get_categories categories
    
    while true; do
        print_main_menu
        echo -n "Select category: "
        read -r choice
        
        case "$choice" in
            q|Q)
                exit 0
                ;;
            a|A)
                download_all
                ;;
            *)
                if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#categories[@]}" ]; then
                    local selected="${categories[$((choice-1))]}"
                    category_menu "$selected"
                fi
                ;;
        esac
    done
}

# Only run main loop if script is executed directly, not when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_loop
fi