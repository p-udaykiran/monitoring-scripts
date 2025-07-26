#!/bin/bash

# Define threshold in percentage (e.g., 80 means 80%)
THRESHOLD=10

# Log file to record disk usage status
LOG_FILE="/tmp/disk_usage_monitor.log"

# Get current date
DATE=$(date +'%Y-%m-%d %H:%M:%S')

# Get disk usage for root partition
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//')

# Check and log based on usage
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "[$DATE] WARNING: Disk usage is above $THRESHOLD%. Current usage: $USAGE%" >> "$LOG_FILE"
else
    echo "[$DATE] OK: Disk usage is under control. Current usage: $USAGE%" >> "$LOG_FILE"
fi
