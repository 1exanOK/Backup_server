Скрипт для бека с серверов на/с main backup_server
На все сервера передан открытый ключ через ssh-copy-id
transport1.sh - Главный скрипт запускающий все скрипты
rsync.sh - rsync с NAS server
rsync_qnap.sh - rsync c Qnap
rsync_zip.sh - скрипт архиваци каждой папки в отдельный архив
rsync_zip.sh - скрипт архивации всех папок в 1 архив ( сделано так из за веса и количества файлов )
