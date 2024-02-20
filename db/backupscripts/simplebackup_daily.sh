#!/bin/sh

DATUM=$(date +"%Y%m%d")

if [ -z "$BACKUP_DB_NAME" ]; then
    if [ -z "$MYSQL_DATABASE" ]; then
        echo "Neither Environment variable BACKUP_DB_NAME nor MYSQL_DATABASE set"
        exit 1
    fi
    BACKUP_DB_NAME=$MYSQL_DATABASE
fi


mariadb-dump -u root --password=$MYSQL_ROOT_PASSWORD $BACKUP_DB_NAME | gzip > "/backup/backup-db-"$BACKUP_DB_NAME"-"$DATUM".sql.gz"
DATUMP=$(date +"%Y-%m-%d %H:%M")
echo "$DATUMP => Backed up database" 
