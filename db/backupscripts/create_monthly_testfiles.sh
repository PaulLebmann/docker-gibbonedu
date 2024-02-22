#!/bin/sh

if [ -z "$BACKUP_DB_NAME" ]; then
    if [ -z "$MYSQL_DATABASE" ]; then
        echo "Neither Environment variable BACKUP_DB_NAME nor MYSQL_DATABASE set"
        exit 1
    fi
    BACKUP_DB_NAME=$MYSQL_DATABASE
fi

DATE_LAST_MONTH=$(date --date="$(date +%Y-%m-15) -1 month" +'%Y%m')
DATE_YESTERDAY=$(date -d "yesterday" +"%Y%m%d")

echo $DATE_LAST_MONTH
echo $DATE_YESTERDAY

for DAY in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
do
	touch /backup/backup-db-"$BACKUP_DB_NAME"-"$DATE_LAST_MONTH$DAY".sql.gz
done
