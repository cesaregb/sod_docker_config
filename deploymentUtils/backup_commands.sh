#!/bin/bash

PGMNAME=`basename $0`

db_user="root"
db_password="Welcome1"

now="$(date +'%d_%m_%Y_%H_%M_%S')"

cloud_database_url="soddb.ca6bb5j2bui8.us-east-1.rds.amazonaws.com:3306";

filename="db_backup_$now".gz

backupfolder="/Users/cesaregb/dev/BKPs/sod_db"
backupfolder_local="${backupfolder}/local"
backupfolder_prod="${backupfolder}/prod"
# TODO pending create folder if dont exist
# TODO assign backupfolder = to whatever environment we are in or we send as argument.

fullpathbackupfile="$backupfolder/$filename"

logfile="$backupfolder/"backup_log_"$(date +'%Y_%m')".txt

echo "mysqldump started at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
mysqldump --user=${db_user} --password=${db_password} --default-character-set=utf8 --single-transaction sod_db | gzip > "$fullpathbackupfile"
echo "mysqldump finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
chown myuser "$fullpathbackupfile"
chown myuser "$logfile"
echo "file permission changed" >> "$logfile"
find "$backupfolder" -name db_backup_* -mtime +8 -exec rm {} \;
echo "old files deleted" >> "$logfile"
echo "operation finished at $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
echo "*****************" >> "$logfile"
exit 0
