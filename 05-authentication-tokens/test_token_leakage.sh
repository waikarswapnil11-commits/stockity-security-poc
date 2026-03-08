#!/bin/bash
# Test for authentication token leakage

echo "=== TESTING TOKEN EXPOSURE ==="

# Check common endpoints that might leak tokens
for endpoint in /api/user /api/profile /api/me /api/account /user/profile; do
    echo "Testing $endpoint"
    curl -s "https://stockity.com$endpoint" | grep -E "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}" -i
done

# Check if tokens appear in API responses
curl -s "https://stockity.com/api/user" -H "Authorization: Bearer YOUR_TOKEN" | grep -E "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}" -i
