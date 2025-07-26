#!/bin/bash

# Title
echo "📊 System Uptime Report"
echo "----------------------------"

# Uptime
echo "🕒 Uptime:"
uptime -p

# Uptime with exact time and load
echo -e "\n📈 Detailed Uptime:"
uptime

# Who is logged in
echo -e "\n👥 Logged-in Users:"
who

# Current time
echo -e "\n⏰ Current System Time:"
date

# System boot time
echo -e "\n🔄 Last Boot Time:"
who -b

echo -e "\n✅ Report Complete."
