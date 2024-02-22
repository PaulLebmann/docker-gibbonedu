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

#DATUM=$(date +"%Y%m%d-%H%M")
DATE_YEAR=$(date +"%Y")
DATE_MONTH_NOW=$(date +"%m")
DATE_LAST_MONTH=$(date --date="$(date +%Y-%m-15) -1 month" +'%Y%m')
DATE_YESTERDAY=$(date -d "yesterday" +"%Y%m%d")

DATUMP=$(date +"%Y-%m-%d %H:%M")
mv "/backup/backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY".sql.gz" "/backup/backup-db-"$BACKUP_DB_NAME"-"$DATE_LAST_MONTH".sql.gz"
echo "$DATUMP => moved backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY".sql.gz to backup-db-"$BACKUP_DB_NAME"-"$DATE_LAST_MONTH".sql.gz"
find /backup/ -regex ".*"$DATE_LAST_MONTH"[0-9][0-9].*" -delete
#find /backup/ -regex ".*"$DATE_LAST_MONTH"[0-9][0-9].*"
#find /backup/ -regex ".*$(echo $DATE_LAST_MONTH)[0-9][0-9].*"

echo "$DATUMP => removed daily backups from $DATE_LAST_MONTH" 
