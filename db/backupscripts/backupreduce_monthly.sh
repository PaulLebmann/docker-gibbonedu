#!/bin/sh

if [ -z "$BACKUP_DB_NAME" ]; then
    if [ -z "$MYSQL_DATABASE" ]; then
        echo "Neither Environment variable BACKUP_DB_NAME nor MYSQL_DATABASE set"
        exit 1
    fi
    BACKUP_DB_NAME=$MYSQL_DATABASE
fi


#DATUM=$(date +"%Y%m%d-%H%M")
DATUMJAHR=$(date +"%Y")
DATUMMONAT=$(date +"%m")
DATUMLETZTERMONAT=$(date --date="$(date +%Y-%m-15) -1 month" +'%Y%m')
DATUMGESTERN=$(date -d "yesterday" +"%Y%m%d")

DATUMP=$(date +"%Y-%m-%d %H:%M")
mv "/backup/backup-db-"$BACKUP_DB_NAME"-"$DATUMGESTERN".sql.gz" "/backup/backup-db-"$BACKUP_DB_NAME"-"$DATUMLETZTERMONAT".sql.gz"
echo "$DATUMP => moved backup-db-"$BACKUP_DB_NAME"-"$DATUMGESTERN".sql.gz to backup-db-"$BACKUP_DB_NAME"-"$DATUMLETZTERMONAT".sql.gz"
find /backup/ -regex ".*"$DATUMLETZTERMONAT"[0-9][0-9].*" -delete
#find /backup/ -regex ".*"$DATUMLETZTERMONAT"[0-9][0-9].*"
#find /backup/ -regex ".*$(echo $DATUMLETZTERMONAT)[0-9][0-9].*"

echo "$DATUMP => removed daily backups from $DATUMLETZTERMONAT" 
