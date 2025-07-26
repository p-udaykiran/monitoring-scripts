#!/bin/bash

# URL to check
url="https://github.com"

# Setup log directory
LOG_DIR="$HOME/health_logs"
mkdir -p "$LOG_DIR"

# Date-based log file
TODAY=$(date +"%y-%m-%d")
LOG_FILE="$LOG_DIR/health_log_$TODAY.log"

# Get HTTP status and response time
response=$(curl -o /dev/null -s -A "Mozilla/5.0" -w "%{http_code} %{time_total}" "$url")

status_code=$(echo "$response" | awk '{print $1}')
response_time=$(echo "$response" | awk '{print $2}')
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"  # No Color

# Print with color based on status
if [ "$status_code" == "200" ]; then
    echo -e "${GREEN}$timestamp | Status: $status_code | Response Time: ${response_time}s${NC}"
elif (( $(echo "$response_time > 1" | bc -l) )); then
    echo -e "${YELLOW}$timestamp | Status: $status_code | Slow Response: ${response_time}s${NC}"
else
    echo -e "${RED}$timestamp | Status: $status_code | Response Time: ${response_time}s${NC}"
fi

# Always log to file (non-colored)
echo "$timestamp | Status: $status_code | Response Time: ${response_time}s" >> "$LOG_FILE"
