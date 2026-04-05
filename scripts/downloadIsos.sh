#!/bin/bash
# Interactive ISO Downloader - Fixed whiptail version
# Run: sudo bash scripts/downloadIsos.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/.."

declare -a ITEMS

add_item() {
    ITEMS+=("$1|$2|$3|$4")
}

add_item "Ubuntu" "Ubuntu 24.04 LTS" "https://releases.ubuntu.com/24.04/ubuntu-24.04.4-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Ubuntu 25.04" "https://releases.ubuntu.com/25.04/ubuntu-25.04-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Kubuntu 24.04 LTS" "https://cdimage.ubuntu.com/kubuntu/releases/24.04/release/kubuntu-24.04.4-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Lubuntu 24.04 LTS" "https://cdimage.ubuntu.com/lubuntu/releases/24.04/release/lubuntu-24.04.4-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Xubuntu 24.04 LTS" "https://cdimage.ubuntu.com/xubuntu/releases/24.04/release/xubuntu-24.04.4-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Ubuntu MATE 24.04" "https://cdimage.ubuntu.com/ubuntu-mate/releases/24.04/release/ubuntu-mate-24.04.4-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Ubuntu Budgie 24.04" "https://cdimage.ubuntu.com/ubuntu-budgie/releases/24.04/release/ubuntu-budgie-24.04.4-desktop-amd64.iso" "01-Linux"
add_item "Ubuntu" "Edubuntu 25.10" "https://cdimage.ubuntu.com/edubuntu/releases/25.10/release/edubuntu-25.10-desktop-amd64.iso" "01-Linux"
add_item "Debian" "Debian 12 Netinst" "https://cdimage.debian.org/cdimage/archive/12.11.0/amd64/iso-cd/debian-12.11.0-amd64-netinst.iso" "01-Linux"
add_item "Debian" "Debian 13 Netinst" "https://cdimage.debian.org/cdimage/release/13.4.0/amd64/iso-cd/debian-13.4.0-amd64-netinst.iso" "01-Linux"
add_item "Other Distros" "Linux Mint 22.1" "https://mirror.metanet.ch/linuxmint-cd/stable/22.1/linuxmint-22.1-cinnamon-64bit.iso" "01-Linux"
add_item "Other Distros" "Linux Mint 22.3" "https://mirror.metanet.ch/linuxmint-cd/stable/22.3/linuxmint-22.3-cinnamon-64bit.iso" "01-Linux"
add_item "Other Distros" "Pop!_OS 24.04" "https://iso.pop-os.org/24.04/amd64/generic/23/pop-os_24.04_amd64_generic_23.iso" "01-Linux"
add_item "Other Distros" "Manjaro KDE 26.0.2" "https://download.manjaro.org/kde/26.0.2/manjaro-kde-26.0.2-260206-linux618.iso" "01-Linux"
add_item "Other Distros" "Elementary OS 8.1" "https://github.com/elementary/os/releases/download/8.1/elementaryos-8.1-stable-amd64.20260219.iso" "01-Linux"
add_item "Security" "Kali Linux 2026.1" "https://kali.download/kali-images/kali-2026.1/kali-linux-2026.1-installer-amd64.iso" "01-Linux"
add_item "Security" "Parrot Security 7.1" "https://bunny.deb.parrot.sh/parrot/iso/7.1/Parrot-security-7.1_amd64.iso" "01-Linux"
add_item "Security" "Parrot Home 7.1" "https://bunny.deb.parrot.sh/parrot/iso/7.1/Parrot-home-7.1_amd64.iso" "01-Linux"
add_item "Fedora" "Fedora 41 Workstation" "https://download.fedoraproject.org/pub/fedora/linux/releases/41/Workstation/x86_64/iso/Fedora-Workstation-41-1.4.x86_64.iso" "01-Linux"
add_item "Enterprise" "Rocky Linux 9.7" "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.7-x86_64-dvd.iso" "01-Linux"
add_item "Enterprise" "AlmaLinux 9" "https://repo.almalinux.org/almalinux/9/isos/x86_64/AlmaLinux-9-latest-x86_64-dvd.iso" "01-Linux"
add_item "Enterprise" "openSUSE Leap 15.6" "https://download.opensuse.org/distribution/leap/15.6/iso/openSUSE-Leap-15.6-DVD-x86_64-Media.iso" "01-Linux"
add_item "Enterprise" "openSUSE Tumbleweed" "https://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Current.iso" "01-Linux"
add_item "Arch" "Arch Linux" "https://geo.mirror.pkgbuild.com/iso/latest/archlinux-x86_64.iso" "01-Linux"
add_item "Tools" "GParted Live" "https://sourceforge.net/projects/gparted/files/gparted-live-stable/1.6.0-1/gparted-live-1.6.0-1-amd64.iso" "03-Tools"
add_item "Tools" "Clonezilla Live" "https://sourceforge.net/projects/clonezilla/files/clonezilla_live_stable/3.1.2-22/clonezilla-live-3.1.2-22-amd64.iso" "03-Tools"
add_item "Tools" "Rescuezilla" "https://sourceforge.net/projects/rescuezilla/files/rescuezilla/stable/2.5/rescuezilla-2.5-64bit.jammy.iso" "03-Tools"
add_item "Lightweight" "antiX 23.2" "https://sourceforge.net/projects/antix-linux/files/Final/antiX-23.2/antiX-23.2_x64-full.iso" "01-Linux"

get_file_size() {
    curl -sI -L "$1" 2>/dev/null | grep -i Content-Length | tail -1 | awk '{print $2}'
}

bytes_to_human() {
    local b=$1
    [ "$b" -eq -1 ] || [ -z "$b" ] && echo "Unknown" && return
    local u=("B" "KB" "MB" "GB" "TB")
    local i=0
    while [ "$b" -gt 1024 ] && [ "$i" -lt 4 ]; do
        b=$((b / 1024))
        ((i++))
    done
    echo "$b ${u[$i]}"
}

check_exists() {
    local n=$(basename "$1")
    [ -f "$TARGET_DIR/$2/$n" ] && echo "true" || echo "false"
}

get_total_size() {
    local sum=0
    for i in "$@"; do
        local itm="${ITEMS[$((i-1))]}"
        IFS='|' read -r c name u p <<< "$itm"
        local sz=$(get_file_size "$u")
        [ -n "$sz" ] && [ "$sz" -gt 0 ] 2>/dev/null && sum=$((sum + sz))
    done
    echo $sum
}

show_menu() {
    local items=()
    local prev_cat=""
    
    for ((i=1; i<=${#ITEMS[@]}; i++)); do
        local itm="${ITEMS[$((i-1))]}"
        IFS='|' read -r c name u p <<< "$itm"
        
        if [ "$c" != "$prev_cat" ]; then
            items+=("" "=== $c ===")
            prev_cat="$c"
        fi
        
        local ex=$(check_exists "$u" "$p")
        local mark="[ ]"
        [ "$ex" = "true" ] && mark="[✓]"
        
        items+=("$i" "$mark $name")
    done
    
    local result
    whiptail --title "Ventoy ISO Downloader" \
        --backtitle "SPACE=toggle, TAB=buttons, ENTER=confirm" \
        --checklist "Select ISOs to download" 28 75 20 "${items[@]}" 2>&1
}

download_items() {
    local selected=("$@")
    [ ${#selected[@]} -eq 0 ] && return
    
    local total
    total=$(get_total_size "${selected[@]}")
    local total_human
    total_human=$(bytes_to_human "$total")
    
    local avail
    avail=$(df -B1 "$TARGET_DIR" 2>/dev/null | awk 'NR==2 {print $4}')
    local avail_human
    avail_human=$(bytes_to_human "$avail")
    
    local list=""
    for i in "${selected[@]}"; do
        local itm="${ITEMS[$((i-1))]}"
        IFS='|' read -r c name u p <<< "$itm"
        list="$list$name\n"
    done
    
    whiptail --title "Download Summary" --yesno \
        "Selected: ${#selected[@]} items\nSize: $total_human\nFree: $avail_human\n\n$list\nStart download?" \
        25 60 || return
    
    if [ -n "$total" ] && [ "$avail" -lt "$total" ]; then
        whiptail --title "Error" --msgbox "Not enough space!" 8 40
        return
    fi
    
    local log="/tmp/ventoy_dl_$$.log"
    > "$log"
    
    local count=1
    local total_count=${#selected[@]}
    
    for idx in "${selected[@]}"; do
        local itm="${ITEMS[$((idx-1))]}"
        IFS='|' read -r c name u p <<< "$itm"
        local fname
        fname=$(basename "$u")
        
        mkdir -p "$TARGET_DIR/$p"
        
        if [ -f "$TARGET_DIR/$p/$fname" ]; then
            echo "✓ Already exists: $name" >> "$log"
            continue
        fi
        
        echo "[$count/$total_count] Downloading: $name" >> "$log"
        
        if wget -O "$TARGET_DIR/$p/$fname" --continue "$u" >> "$log" 2>&1; then
            echo "✓ Success: $name" >> "$log"
        else
            echo "✗ Failed: $name" >> "$log"
            rm -f "$TARGET_DIR/$p/$fname"
        fi
        
        ((count++))
    done
    
    whiptail --title "Complete" --textbox "$log" 24 80
    rm -f "$log"
}

# Main
while true; do
    result=$(show_menu)
    ret=$?
    
    [ $ret -ne 0 ] && break
    
    declare -a selected
    for item in $result; do
        selected+=("$item")
    done
    
    [ ${#selected[@]} -gt 0 ] && download_items "${selected[@]}"
done
