#!/bin/bash
# Subdomain Enumeration PoC

echo "[*] Enumerating subdomains of stockity.com..."

# Using common tools
echo "[*] Running subfinder..."
subfinder -d stockity.com -silent -o subfinder-results.txt

echo "[*] Running assetfinder..."
assetfinder --subs-only stockity.com | tee -a assetfinder-results.txt

echo "[*] Checking each subdomain for accessibility..."
cat subfinder-results.txt assetfinder-results.txt | sort -u | while read sub; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "https://$sub" 2>/dev/null)
    title=$(curl -s "https://$sub" 2>/dev/null | grep -o "<title>[^<]*" | head -1 | sed 's/<title>//')
    
    if [ -n "$status" ] && [ "$status" != "000" ]; then
        echo "[$status] $sub - $title"
    fi
done