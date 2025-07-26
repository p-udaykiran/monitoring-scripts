#!/bin/bash

echo "🔍 Listing open ports and associated services..."
echo "--------------------------------------------------"

# Display open ports using ss
ss -tuln

echo -e "\n📌 Detailed view with process info (using lsof)..."
echo "--------------------------------------------------"

# Display open ports with associated processes
sudo lsof -i -P -n | grep LISTEN

echo -e "\n✅ Script complete."
