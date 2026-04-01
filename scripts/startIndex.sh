#!/bin/bash
# Start a local web server to view index.html

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

echo "========================================"
echo "  Ventoy USB Index Server"
echo "========================================"
echo ""
echo "Server starting at: http://localhost:8080"
echo "Open this URL in your browser"
echo ""
echo "Press Ctrl+C to stop"
echo ""

python3 -m http.server 8080