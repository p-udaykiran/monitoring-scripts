#!/bin/bash

# Directory to store backups
BACKUP_DIR="$HOME/db_backups"
mkdir -p "$BACKUP_DIR"

# Prompt for database name
read -rp "Enter the MySQL database name to back up: " DB_NAME

# Check for empty input
if [[ -z "$DB_NAME" ]]; then
  echo "❌ Error: Database name cannot be empty."
  exit 1
fi

# Prompt for MySQL credentials
read -rp "Enter MySQL username [default: root]: " DB_USER
DB_USER=${DB_USER:-root}

read -srp "Enter MySQL password for user '$DB_USER': " DB_PASS
echo

# Timestamped backup file name
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_backup_$TIMESTAMP.sql"

# Backup using mysqldump
echo "🔄 Backing up database '$DB_NAME'..."
mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE" 2> /tmp/backup_error.log

# Check if backup was successful
if [[ $? -eq 0 ]]; then
  echo "✅ Backup successful!"
  echo "📁 File saved at: $BACKUP_FILE"
else
  echo "❌ Backup failed!"
  cat /tmp/backup_error.log
  rm -f "$BACKUP_FILE"
fi

# Clean up error log
rm -f /tmp/backup_error.log
