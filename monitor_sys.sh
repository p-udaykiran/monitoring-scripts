#!/bin/bash

# Optional: Log file
LOG_FILE="/var/log/sys_monitor.log"

echo "📊 System Process and Memory Usage Report - $(date)"
echo "----------------------------------------------------"

# Top 5 memory-consuming processes
echo -e "\n🔍 Top 5 Memory Consuming Processes:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

# Top 5 CPU-consuming processes
echo -e "\n🔥 Top 5 CPU Consuming Processes:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# Total memory usage
echo -e "\n🧠 Memory Usage:"
free -h

# Optional: log to file
if [ "$1" == "--log" ]; then
  {
    echo -e "\n--- $(date) ---"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    free -h
  } >> "$LOG_FILE"
fi
