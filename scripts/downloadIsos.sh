#!/bin/bash
# Interactive ISO Downloader - Hierarchical Selection
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

# Selected items for download
declare -a SELECTED_INDICES

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
add_item "Penetration Testing" "Parrot Security 7.1" \
    "https://bunny.deb.parrot.sh/parrot/iso/7.1/Parrot-security-7.1_amd64.iso" \
    "Linux/apt/Parrot"

add_item "Penetration Testing" "Parrot Home 7.1" \
    "https://bunny.deb.parrot.sh/parrot/iso/7.1/Parrot-home-7.1_amd64.iso" \
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

get_items_in_category() {
    local category="$1"
    local indices=()
    local global_idx=1
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r cat name url path <<< "$item"
        if [ "$cat" = "$category" ]; then
            indices+=($global_idx)
        fi
        ((global_idx++))
    done
    echo "${indices[@]}"
}

get_remote_file_size() {
    local url="$1"
    local size_bytes
    size_bytes=$(curl -sI -L "$url" 2>/dev/null | grep -i "Content-Length" | tail -1 | tr -d '\r' | awk '{print $2}')
    if [[ -z "$size_bytes" || "$size_bytes" == "0" ]]; then
        echo "-1"
    else
        echo "$size_bytes"
    fi
}

bytes_to_human() {
    local bytes=$1
    if [ "$bytes" -eq -1 ]; then
        echo "Unknown"
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

is_selected() {
    local idx=$1
    for sel in "${SELECTED_INDICES[@]}"; do
        if [ "$sel" -eq "$idx" ]; then
            return 0
        fi
    done
    return 1
}

get_total_size() {
    local total=0
    for idx in "${SELECTED_INDICES[@]}"; do
        local item="${ITEMS[$((idx-1))]}"
        IFS='|' read -r cat name url path <<< "$item"
        local size=$(get_remote_file_size "$url")
        if [ "$size" -gt 0 ] 2>/dev/null; then
            total=$((total + size))
        fi
    done
    echo $total
}

print_main_menu() {
    local categories
    get_categories categories
    
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║              VENTOY ISO DOWNLOADER                         ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "Select categories to browse (or press Enter to see summary):"
    echo ""
    
    local idx=1
    for cat in "${categories[@]}"; do
        local count=0
        local selected=0
        for item in "${ITEMS[@]}"; do
            IFS='|' read -r c n u p <<< "$item"
            [ "$c" = "$cat" ] && ((count++))
        done
        
        local indices=($(get_items_in_category "$cat"))
        for i in "${indices[@]}"; do
            is_selected "$i" && ((selected++))
        done
        
        if [ "$selected" -gt 0 ]; then
            printf "  ${GREEN}[%2d]${NC} %-20s ${GREEN}(%d selected)${NC}\n" "$idx" "$cat" "$selected"
        else
            printf "  ${GREEN}[%2d]${NC} %-20s ${YELLOW}(%d items)${NC}\n" "$idx" "$cat" "$count"
        fi
        ((idx++))
    done
    
    echo ""
    echo -e "  ${CYAN}[D]${NC} Download selected (${#SELECTED_INDICES[@]} items)"
    echo -e "  ${CYAN}[C]${NC} Clear selection"
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
    echo "Toggle selections (comma-separated): 1,2,3"
    echo "Press Enter when done, B to go back"
    echo ""
    
    local idx=1
    local global_idx=1
    for item in "${ITEMS[@]}"; do
        IFS='|' read -r cat name url path <<< "$item"
        if [ "$cat" = "$category" ]; then
            local filename
            filename=$(basename "$url")
            local exists=""
            if [ -f "$TARGET_DIR/$path/$filename" ]; then
                exists="${GREEN}✓${NC} "
            fi
            
            if is_selected "$global_idx"; then
                printf "  ${GREEN}[%2d]${NC} ${GREEN}●${NC} %-38s ${YELLOW}→ ${path}/${NC}\n" "$idx" "$exists$name"
            else
                printf "  ${GREEN}[%2d]${NC}   %-40s ${YELLOW}→ ${path}/${NC}\n" "$idx" "$exists$name"
            fi
            ((idx++))
        fi
        ((global_idx++))
    done
    echo ""
}

toggle_selection() {
    local cat_idx=$1
    local categories
    get_categories categories
    local category="${categories[$((cat_idx-1))]}"
    
    while true; do
        print_category_items "$category"
        echo -n "Toggle (or B to go back): "
        read -r choice
        
        case "$choice" in
            b|B)
                return
                ;;
            "")
                return
                ;;
            *)
                local indices=($(get_items_in_category "$category"))
                IFS=',' read -ra SELECTIONS <<< "$choice"
                
                for sel in "${SELECTIONS[@]}"; do
                    sel=$(echo "$sel" | xargs)
                    if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -ge 1 ] && [ "$sel" -le "${#indices[@]}" ]; then
                        local global_idx="${indices[$((sel-1))]}"
                        
                        if is_selected "$global_idx"; then
                            # Remove from selection
                            local new_array=()
                            for s in "${SELECTED_INDICES[@]}"; do
                                [ "$s" -ne "$global_idx" ] && new_array+=("$s")
                            done
                            SELECTED_INDICES=("${new_array[@]}")
                        else
                            # Add to selection
                            SELECTED_INDICES+=("$global_idx")
                        fi
                    fi
                done
                ;;
        esac
    done
}

download_selected() {
    if [ ${#SELECTED_INDICES[@]} -eq 0 ]; then
        echo -e "${RED}No items selected!${NC}"
        return
    fi
    
    # Get total size
    echo -e "${CYAN}Calculating total size...${NC}"
    local total_size
    total_size=$(get_total_size)
    local total_human
    total_human=$(bytes_to_human "$total_size")
    
    # Get available space
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
        if [[ ! "$confirm" =~ ^[Yy] ]]; then
            return
        fi
        # Show selection management
        print_selection_manager
        return
    fi
    
    echo -e "Start download? (y/N)${NC}"
    read -r confirm
    if [[ ! "$confirm" =~ ^[Yy] ]]; then
        return
    fi
    
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
        if [ "$size_bytes" -gt 0 ]; then
            echo -e "  Size: $(bytes_to_human "$size_bytes")"
        fi
        
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
    echo ""
    # Clear selection after download
    SELECTED_INDICES=()
    echo "Press Enter to continue..."
    read
}

print_selection_manager() {
    while true; do
        clear
        echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}║              MANAGE SELECTION                              ║${NC}"
        echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo "Enter number to toggle, D to download, C to clear, Q to quit"
        echo ""
        
        local idx=1
        for global_idx in "${SELECTED_INDICES[@]}"; do
            local item="${ITEMS[$((global_idx-1))]}"
            IFS='|' read -r cat name url path <<< "$item"
            printf "  ${GREEN}[%2d]${NC} %-40s (${cat})\n" "$idx" "$name"
            ((idx++))
        done
        
        if [ ${#SELECTED_INDICES[@]} -eq 0 ]; then
            echo "  No items selected"
        fi
        
        echo ""
        echo -n "Choice: "
        read -r choice
        
        case "$choice" in
            d|D)
                download_selected
                return
                ;;
            c|C)
                SELECTED_INDICES=()
                echo "Selection cleared"
                sleep 1
                return
                ;;
            q|Q)
                exit 0
                ;;
            *)
                if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#SELECTED_INDICES[@]} ]; then
                    local remove_idx=$((choice - 1))
                    local new_array=()
                    local pos=0
                    for s in "${SELECTED_INDICES[@]}"; do
                        if [ "$pos" -ne "$remove_idx" ]; then
                            new_array+=("$s")
                        fi
                        ((pos++))
                    done
                    SELECTED_INDICES=("${new_array[@]}")
                fi
                ;;
        esac
    done
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
            d|D)
                print_selection_manager
                ;;
            c|C)
                SELECTED_INDICES=()
                echo "Selection cleared"
                ;;
            *)
                if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#categories[@]}" ]; then
                    toggle_selection "$choice"
                fi
                ;;
        esac
    done
}

# Only run main loop if script is executed directly, not when sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main_loop
fi