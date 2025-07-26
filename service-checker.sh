#!/bin/bash

# Ask for comma-separated service names
read -p "Enter the services to monitor (comma-separated, e.g., apache2,sshd,docker): " input_services

# Convert comma-separated to array
IFS=',' read -ra SERVICES <<< "$input_services"

# Log file setup
LOG_FILE="/tmp/multi_service_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Loop through each service
for SERVICE_NAME in "${SERVICES[@]}"; do
    SERVICE_NAME=$(echo "$SERVICE_NAME" | xargs)  # Trim any whitespace

    echo -e "\n[$DATE] 🔍 Checking service: $SERVICE_NAME" | tee -a "$LOG_FILE"

    # Check if the service exists
    if ! systemctl list-unit-files | grep -q "^$SERVICE_NAME.service"; then
        echo "[$DATE] ❌ Service '$SERVICE_NAME' is not installed or unavailable." | tee -a "$LOG_FILE"
        continue
    fi

    # Check if the service is active
    if systemctl is-active --quiet "$SERVICE_NAME"; then
        echo "[$DATE] ✅ '$SERVICE_NAME' is already running." | tee -a "$LOG_FILE"
    else
        echo "[$DATE] ⚠️ '$SERVICE_NAME' is NOT running. Attempting to start it..." | tee -a "$LOG_FILE"
        sudo systemctl start "$SERVICE_NAME"

        # Verify again after attempting to start
        if systemctl is-active --quiet "$SERVICE_NAME"; then
            echo "[$DATE] ✅ '$SERVICE_NAME' started successfully." | tee -a "$LOG_FILE"
        else
            echo "[$DATE] ❌ Failed to start '$SERVICE_NAME'." | tee -a "$LOG_FILE"
        fi
    fi
done
