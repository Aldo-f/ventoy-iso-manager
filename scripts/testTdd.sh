#!/bin/bash
# TDD Test script for downloadIsos.sh debugging

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/downloadIsos.sh"

echo "=== TDD DEBUG TESTS ==="
echo ""

# Test 1: Check ITEMS array
echo "TEST 1: Check ITEMS array"
echo "Total items: ${#ITEMS[@]}"
echo ""

# Test 2: Find Parrot items
echo "TEST 2: Find Parrot items (should be indices 12 and 13)"
idx=1
for item in "${ITEMS[@]}"; do
    IFS='|' read -r cat name url path <<< "$item"
    if [[ "$name" =~ Parrot ]]; then
        echo "  [$idx] $name -> $path"
    fi
    ((idx++))
done
echo ""

# Test 3: Get items in Penetration Testing category
echo "TEST 3: Get items in Penetration Testing category"
indices=$(get_items_in_category "Penetration Testing")
echo "Indices: $indices"
echo ""

# Test 4: Simulate selection "13"
echo "TEST 4: Simulate selection '13'"
choice="13"
all_indices=($indices)
echo "all_indices count: ${#all_indices[@]}"
echo "all_indices[@]: ${all_indices[@]}"

IFS=',' read -ra SELECTIONS <<< "$choice"
for sel in "${SELECTIONS[@]}"; do
    sel=$(echo "$sel" | xargs)
    echo "Processing selection: '$sel'"
    
    if [[ "$sel" =~ ^[0-9]+$ ]]; then
        echo "  -> Matches number pattern"
        echo "  -> sel: $sel, range: 1-${#all_indices[@]}"
        if [ "$sel" -ge 1 ] && [ "$sel" -le "${#all_indices[@]}" ]; then
            echo "  -> Within range"
            real_idx="${all_indices[$((sel-1))]}"
            echo "  -> real_idx: $real_idx"
            
            # Get the actual item
            item="${ITEMS[$((real_idx-1))]}"
            IFS='|' read -r cat name url path <<< "$item"
            echo "  -> Item: $name"
            echo "  -> URL: $url"
            echo "  -> Path: $path"
        else
            echo "  -> OUT OF RANGE!"
        fi
    else
        echo "  -> Does NOT match number pattern"
    fi
done
echo ""

# Test 5: Check if TARGET_DIR is correct
echo "TEST 5: Check TARGET_DIR"
echo "TARGET_DIR: $TARGET_DIR"
echo ""

# Test 6: Test download_item directly for Parrot
echo "TEST 6: Test download_item for Parrot Home (index 13)"
download_item 13

echo ""
echo "=== TESTS COMPLETE ==="