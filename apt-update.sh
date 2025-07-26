#!/bin/bash

echo "🔄 Starting system update and upgrade..."
echo "----------------------------------------"

# Update package list
sudo apt update -y

# Upgrade all packages
sudo apt upgrade -y

# Clean up unnecessary packages
sudo apt autoremove -y
sudo apt clean

echo "✅ System is up-to-date!"
