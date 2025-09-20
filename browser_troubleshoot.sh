#!/bin/bash

echo "🔍 Browser Access Troubleshooting for dgacic.42.fr"
echo "=================================================="

echo "1. Testing domain resolution:"
nslookup dgacic.42.fr || echo "❌ DNS resolution failed"

echo -e "\n2. Testing hosts file entry:"
grep "dgacic.42.fr" /etc/hosts || echo "❌ No hosts entry found"

echo -e "\n3. Testing ping:"
ping -c 1 dgacic.42.fr && echo "✅ Domain resolves" || echo "❌ Domain doesn't resolve"

echo -e "\n4. Testing HTTPS access:"
curl -k https://dgacic.42.fr --connect-timeout 5 -s -o /dev/null -w "Status: %{http_code}\n" || echo "❌ HTTPS access failed"

echo -e "\n5. Testing port 443:"
timeout 5 bash -c "</dev/tcp/dgacic.42.fr/443" && echo "✅ Port 443 open" || echo "❌ Port 443 blocked"

echo -e "\n6. Container status:"
docker ps --format "table {{.Names}}\t{{.Status}}" | grep -E "nginx|wordpress|mariadb"

echo -e "\n7. NGINX logs (last 5 lines):"
docker logs nginx 2>/dev/null | tail -5 || echo "No NGINX logs"

echo -e "\n✅ If all tests pass, the issue is browser-specific (DNS cache/certificates)"
echo "🌐 Try: https://localhost or https://172.31.197.210 first"