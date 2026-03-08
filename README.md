# Create README
cat > README.md << 'EOF'
# 🔴 Stockity.com Security Vulnerabilities - Private Disclosure

## 📋 Overview
This repository contains proof-of-concept demonstrations for critical security vulnerabilities discovered on stockity.com.

## 🔥 Vulnerability Summary
| Severity | Category | Location |
|----------|----------|----------|
| CRITICAL | Git Repository Exposure | `01-git-exposure/` |
| CRITICAL | Environment File Exposure | `02-env-files/` |
| CRITICAL | Database Backups | `03-backup-files/` |
| HIGH | Admin Panel Exposure | `04-admin-panels/` |
| CRITICAL | Authentication Tokens | `05-authentication-tokens/` |
| MEDIUM | Source Map Exposure | `06-source-maps/` |
| MEDIUM | Directory Listings | `07-directory-listing/` |
| MEDIUM | Server Info Disclosure | `08-server-info/` |

## 🔐 Access
This repository is **PRIVATE** and shared only with Stockity security team.

## 📞 Contact
**Security Researcher**: waikarswapnil11
**Repository**: https://github.com/waikarswapnil11-commits/stockity-security-poc
EOF

# Create .gitignore
cat > .gitignore << 'EOF'
# Sensitive files that shouldn't be committed
*.key
*.pem
*.crt
*.log
.DS_Store
*.swp
*.swo
*~
*.bak
.idea/
.vscode/
EOF

# Create verification script
cat > scripts/verify-poc.sh << 'EOF'
#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}=== Stockity.com PoC Verification ===${NC}\n"

# Check if directories exist
check_dir() {
    if [ -d "$1" ]; then
        files=$(ls -1 "$1" 2>/dev/null | wc -l)
        if [ "$files" -gt 0 ]; then
            echo -e "${GREEN}[✓] $1 ($files files)${NC}"
        else
            echo -e "${RED}[✗] $1 (empty)${NC}"
        fi
    else
        echo -e "${RED}[✗] $1 (missing)${NC}"
    fi
}

check_dir "01-git-exposure"
check_dir "02-env-files"
check_dir "03-backup-files"
check_dir "04-admin-panels"
check_dir "05-authentication-tokens"
check_dir "06-source-maps"
check_dir "07-directory-listing"
check_dir "08-server-info"
check_dir "09-subdomain-enum"
check_dir "10-wildcard-fuzzing"
check_dir "documentation"
check_dir "scripts"

echo -e "\n${YELLOW}Total files:${NC} $(find . -type f -not -path "*/\.*" | wc -l)"
echo -e "${GREEN}✓ Repository ready for submission${NC}"
EOF

chmod +x scripts/verify-poc.sh