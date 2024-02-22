#!/bin/sh
if [ -z "$BACKUP_DB_NAME" ]; then
    if [ -z "$MARIADB_DATABASE" ]; then
        if [ -z "$MYSQL_DATABASE" ]; then
            echo "Neither Environment variable BACKUP_DB_NAME nor MARIADB_DATABASE or MYSQL_DATABASE are set"
            exit 1
        else
            BACKUP_DB_NAME=$MYSQL_DATABASE
        fi
    else
        BACKUP_DB_NAME=$MARIADB_DATABASE
    fi
fi

DATE_NOW=$(date +"%Y%m%d-%H%M")
DATE_YESTERDAY_BACKUP_NAME=$(date -d "yesterday 23:00" +"%Y%m%d-%H%M")
DATE_YESTERDAY=$(date -d "yesterday" +"%Y%m%d")

DATE_PRINT=$(date +"%Y-%m-%d %H:%M")
mv /backup/backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY"-23* /backup/backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY".sql.gz
echo "$DATE_PRINT => moved backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY_BACKUP_NAME".sql.gz to backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY".sql.gz"
find /backup/ -name \*${DATE_YESTERDAY}-\* -delete

echo "$DATE_PRINT => removed hourly backups from $DATE_YESTERDAY" 
