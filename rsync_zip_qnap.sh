#!/bin/bash


SOURCE_DIR="/media/hdd/rsync/ObmenBuh"
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")


DEST_DIR="/media/hdd/Backup/QNAP/ObmenBuh"
mkdir -p "$DEST_DIR"


ARCHIVE_NAME="backup_$CURRENT_DATE.tar.gz"


LOG_DIR="/media/hdd/zip_log/QNAP"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/backup_$CURRENT_DATE.log"


echo "$(date +"%Y-%m-%d %H:%M:%S") - Архивация начата" >> "$LOG_FILE"


tar -czf "$DEST_DIR/$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")" 2>> "$LOG_FILE"


if [ $? -eq 0 ]; then
  echo "$(date +"%Y-%m-%d %H:%M:%S") - Архивация завершена успешно: $ARCHIVE_NAME" >> "$LOG_FILE"
else
  echo "$(date +"%Y-%m-%d %H:%M:%S") - Ошибка при архивации: $ARCHIVE_NAME" >> "$LOG_FILE"
fi
