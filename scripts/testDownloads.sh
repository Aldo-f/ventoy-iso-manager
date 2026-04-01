#!/bin/bash
# Test all download URLs
# Run: bash scripts/testDownloads.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DL_SCRIPT="$SCRIPT_DIR/downloadIsos.sh"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0
TOTAL=0

test_url() {
    local name="$1"
    local url="$2"
    local idx="$3"
    
    echo -ne "${CYAN}[$idx]${NC} ${name}..."
    
    local http_code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 15 -I "$url" 2>/dev/null)
    
    if [ "$http_code" = "200" ] || [ "$http_code" = "302" ] || [ "$http_code" = "301" ]; then
        echo -e " ${GREEN}✓${NC}"
        ((PASS++))
    else
        echo -e " ${RED}✗ ($http_code)${NC}"
        ((FAIL++))
    fi
}

echo ""
echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}           VENTOY ISO URL TESTER                         ${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"
echo ""

# Parse downloadIsos.sh and extract URLs
idx=1
while IFS= read -r line; do
    # Match name line: add_item "Category" "Name" \
    if [[ "$line" =~ add_item\ \"([^\"]+)\"\ \"([^\"]+)\" ]]; then
        category="${BASH_REMATCH[1]}"
        name="${BASH_REMATCH[2]}"
        
        # Read next line for URL
        read -r url_line
        if [[ "$url_line" =~ \"(https?://[^\"]+)\" ]]; then
            url="${BASH_REMATCH[1]}"
            test_url "$name" "$url" "$idx"
            ((idx++))
            ((TOTAL++))
        fi
    fi
done < "$DL_SCRIPT"

echo ""
echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"
echo -e "  Total: $TOTAL  |  ${GREEN}Pass: $PASS${NC}  |  ${RED}Fail: $FAIL${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════════════${NC}"
echo ""

[ $FAIL -eq 0 ] && echo -e "${GREEN}All URLs working!${NC}" || echo -e "${YELLOW}Some URLs failed${NC}"

exit $FAIL