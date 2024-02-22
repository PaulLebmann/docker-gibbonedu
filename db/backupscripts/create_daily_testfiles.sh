#!/bin/sh
if [ -z "$BACKUP_DB_NAME" ]; then
    if [ -z "$MYSQL_DATABASE" ]; then
        echo "Neither Environment variable BACKUP_DB_NAME nor MYSQL_DATABASE set"
        exit 1
    fi
    BACKUP_DB_NAME=$MYSQL_DATABASE
fi


DATE_YESTERDAY=$(date -d "yesterday" +"%Y%m%d")


for TIME_MINUTE in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
do
	touch /backup/backup-db-"$BACKUP_DB_NAME"-"$DATE_YESTERDAY"-"$TIME_MINUTE"-02.sql.gz
done
