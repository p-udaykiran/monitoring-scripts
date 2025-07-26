#!/bin/bash

# ---------------------- CONFIGURATION ----------------------

SOURCE="/home/udaykiran/Pictures"
DESTINATION="/home/udaykiran/Documents/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="backup_$DATE"
BACKUP_DIR="$DESTINATION/$BACKUP_NAME"
TAR_FILE="$DESTINATION/$BACKUP_NAME.tar.gz"
LOG_FILE="$DESTINATION/backup_log.txt"
EMAIL="udaypagidimari@gmail.com"         # <-- Replace with your real email
RETENTION_DAYS=7
LOG_RETENTION_DAYS=30
ENCRYPT=false
ENCRYPT_KEY="Pass"

# ---------------------- COLORS ----------------------

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

# ---------------------- START BACKUP ----------------------

echo -e "${YELLOW}🚀 Starting backup at $DATE${NC}"
mkdir -p "$BACKUP_DIR"

# ---------------------- COPY FILES ----------------------

if rsync -avh --progress "$SOURCE/" "$BACKUP_DIR" >> "$LOG_FILE" 2>&1; then
    echo -e "${GREEN}✅ Files copied successfully to $BACKUP_DIR${NC}"
else
    echo -e "${RED}❌ Error: Failed to copy files${NC}"
    echo "$DATE | FAILED during rsync" >> "$LOG_FILE"
    echo "Backup failed during rsync at $DATE" | mail -s "🔴 Backup FAILED" "$EMAIL"
    exit 1
fi

# ---------------------- COMPRESS ----------------------

echo -e "${YELLOW}📦 Compressing backup folder...${NC}"
tar -czf "$TAR_FILE" -C "$DESTINATION" "$BACKUP_NAME"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Successfully compressed to $TAR_FILE${NC}"
    echo "$DATE | Backup SUCCESSFUL: $TAR_FILE" >> "$LOG_FILE"
else
    echo -e "${RED}❌ Compression failed${NC}"
    echo "$DATE | FAILED during compression" >> "$LOG_FILE"
    echo "Backup failed during compression at $DATE" | mail -s "🔴 Backup FAILED" "$EMAIL"
    exit 1
fi

# ---------------------- OPTIONAL ENCRYPTION ----------------------

if [ "$ENCRYPT" = true ]; then
    echo -e "${YELLOW}🔐 Encrypting backup...${NC}"
    openssl enc -aes-256-cbc -salt -in "$TAR_FILE" -out "$TAR_FILE.enc" -pass pass:"$ENCRYPT_KEY"
    if [ $? -eq 0 ]; then
        rm -f "$TAR_FILE"
        echo -e "${GREEN}🔒 Encrypted to $TAR_FILE.enc${NC}"
    else
        echo -e "${RED}❌ Encryption failed${NC}"
        echo "$DATE | FAILED during encryption" >> "$LOG_FILE"
        exit 1
    fi
fi

# ---------------------- CLEANUP ----------------------

rm -rf "$BACKUP_DIR"

find "$DESTINATION" -type f -name "backup_*.tar.gz*" -mtime +$RETENTION_DAYS -exec rm -f {} \;
find "$DESTINATION" -type f -name "backup_*.enc" -mtime +$RETENTION_DAYS -exec rm -f {} \;

find "$DESTINATION" -name "backup_log.txt" -mtime +$LOG_RETENTION_DAYS -delete

# ---------------------- FINAL SUCCESS ----------------------

echo -e "${GREEN}✅ Backup completed successfully on $DATE${NC}"
echo "Backup completed successfully at $DATE" | mail -s "✅ Backup Success" "$EMAIL"
