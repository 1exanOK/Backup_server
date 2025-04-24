#!/bin/bash


SOURCE_DIR="/media/hdd/rsync/WINshared"
CURRENT_DATE=$(date +"%Y-%m-%d_%H-%M-%S")


DEST_DIR="/media/hdd/Backup/TNAS/backup_$CURRENT_DATE"
mkdir -p "$DEST_DIR"


LOG_FILE="/media/hdd/zip_log/TNAS/backup_$CURRENT_DATE.log"
mkdir -p "/media/hdd/zip_log"


echo "$(date +"%Y-%m-%d %H:%M:%S") - Архивация начата" >> "$LOG_FILE"


for dir in "$SOURCE_DIR"/*; do
  if [ -d "$dir" ]; then
    dirname=$(basename "$dir")
    tar -czf "$DEST_DIR/$dirname.tar.gz" -C "$SOURCE_DIR" "$dirname" 2>> "$LOG_FILE"
    
    if [ $? -eq 0 ]; then
      echo "$(date +"%Y-%m-%d %H:%M:%S") - Архив создан: $dirname.tar.gz" >> "$LOG_FILE"
    else
      echo "$(date +"%Y-%m-%d %H:%M:%S") - Ошибка при создании архива: $dirname.tar.gz" >> "$LOG_FILE"
    fi
  fi
done

echo "$(date +"%Y-%m-%d %H:%M:%S") - Архивация завершена" >> "$LOG_FILE"
