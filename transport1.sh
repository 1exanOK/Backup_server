#!/bin/bash


TNAS="root <ip tnas>"
COMMAND="/media/hdd/Scripts/rsync.sh"

SCRIPT="/media/hdd/Scripts/rsync_zip.sh"
SCRIPT2="/media/hdd/Scripts/rsync_zip_qnap.sh"
DEL_SCRIPT="Bash /media/hdd/Scripts/Delete.sh"

QNAS="admin <ip qnap>"
COMMAND2="/media/hdd/Scripts/rsync_qnap.sh"

TOKEN="BOT_TOKEN"
CHAT_ID="884722934"
REMOTE_MESSAGE="Ошибка где то на удаленном сервере"
BAD_MESSAGE="Ошибка в работе скрипта, проверяй логи"
BAD_MESSAGE1="Ошибка с truenas, чекай логи"
GOOD_MESSAGE="Скрипт отработал штатно, отдыхаем"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
LOG_FILE="/var/log/script.log"


send_message() {
    local message=$1
    echo "$(date "+%Y-%m-%d %H:%M:%S") - Sending message: $message" | tee -a "$LOG_FILE"
    curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$message" >> "$LOG_FILE" 2>&1
}


run() {
    local login=$1
    local host=$2
    local command=$3
    echo "$(date "+%Y-%m-%d %H:%M:%S") - Running command on $host: $command" | tee -a "$LOG_FILE"
    ssh "$login@$host" 'bash -s' < "$command" >> "$LOG_FILE" 2>&1
    return $?  
}


run $TNAS $COMMAND
if [ $? -eq 0 ]; then
    echo "$(date "+%Y-%m-%d %H:%M:%S") - TNAS script executed successfully" | tee -a "$LOG_FILE"
    $SCRIPT >> "$LOG_FILE" 2>&1
else
    echo "$(date "+%Y-%m-%d %H:%M:%S") - TNAS script failed" | tee -a "$LOG_FILE"
    send_message "$REMOTE_MESSAGE"
fi


run $QNAS $COMMAND2
if [ $? -eq 0 ]; then
    echo "$(date "+%Y-%m-%d %H:%M:%S") - QNAP script executed successfully" | tee -a "$LOG_FILE"
    $SCRIPT2 >> "$LOG_FILE" 2>&1
else
    echo "$(date "+%Y-%m-%d %H:%M:%S") - QNAP script failed" | tee -a "$LOG_FILE"
    send_message "$REMOTE_MESSAGE"
fi
