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

DATUM=$(date +"%Y%m%d-%H%M")
DATUMGESTERNBACKUP=$(date -d "yesterday 23:00" +"%Y%m%d-%H%M")
DATUMGESTERN=$(date -d "yesterday" +"%Y%m%d")

DATUMP=$(date +"%Y-%m-%d %H:%M")
mv /backup/backup-db-"$BACKUP_DB_NAME"-"$DATUMGESTERN"-23* /backup/backup-db-"$BACKUP_DB_NAME"-"$DATUMGESTERN".sql.gz
echo "$DATUMP => moved backup-db-"$BACKUP_DB_NAME"-"$DATUMGESTERNBACKUP".sql.gz to backup-db-"$BACKUP_DB_NAME"-"$DATUMGESTERN".sql.gz"
find /backup/ -name \*${DATUMGESTERN}-\* -delete

echo "$DATUMP => removed hourly backups from $DATUMGESTERN" 
