#!/bin/bash

# Default URLs (can be overridden by arguments)
URL1=${1:-"https://github.com"}
URL2=${2:-"https://google.com"}

# Function to get total time from curl
get_time() {
    curl -o /dev/null -s -w "%{time_total}" "$1"
}

# Get response times
TIME1=$(get_time "$URL1")
TIME2=$(get_time "$URL2")

# Print results
echo "🌐 HTTP Response Time Comparison"
echo "--------------------------------"
echo "$URL1 : ${TIME1}s"
echo "$URL2 : ${TIME2}s"

# Compare
echo -n "📊 Result: "
if (( $(echo "$TIME1 < $TIME2" | bc -l) )); then
    echo "$URL1 is faster"
elif (( $(echo "$TIME1 > $TIME2" | bc -l) )); then
    echo "$URL2 is faster"
else
    echo "Both have equal response time"
fi
