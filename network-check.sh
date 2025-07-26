#!/bin/bash

echo "🌐 Network Connectivity Checker"
echo "--------------------------------"

# Prompt user for input
read -p "Enter IP address or domain to check (e.g., 8.8.8.8 or google.com): " target

# Validate input
if [[ -z "$target" ]]; then
  echo "❌ Error: No input provided. Please enter a valid IP or domain."
  exit 1
fi

echo ""
echo "📍 Target: $target"
echo "--------------------------------"

# 1. Ping Check
echo "🔄 Pinging $target..."
if ping -c 2 "$target" > /dev/null 2>&1; then
  echo "✅ Ping: $target is reachable."
else
  echo "❌ Ping: $target is not reachable."
fi

# 2. DNS Resolution (only if domain is entered)
if [[ "$target" =~ [a-zA-Z] ]]; then
  echo "🔍 Resolving DNS for $target..."
  if nslookup "$target" > /dev/null 2>&1; then
    echo "✅ DNS: Resolution successful."
  else
    echo "❌ DNS: Failed to resolve $target."
  fi
fi

# 3. HTTP Accessibility Check
echo "🌐 Checking HTTP(S) accessibility..."
if curl -s --head --max-time 5 "https://$target" | grep -q "200 OK"; then
  echo "✅ HTTP: $target is reachable via HTTPS (200 OK)."
else
  echo "⚠️ HTTP: $target may not be reachable via HTTPS or did not return 200 OK."
fi

echo "--------------------------------"
echo "✅ Network check complete."
