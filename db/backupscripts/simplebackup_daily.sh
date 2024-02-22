#!/bin/sh

BACKUP_DATE=$(date +"%Y%m%d")

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
if [ -z "$BACKUP_DB_ROOT_PW" ]; then
    if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
        if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
            echo "Neither Environment variable BACKUP_DB_NAME nor MARIADB_DATABASE or MYSQL_DATABASE are set"
	    exit 1
	else
	    BACKUP_DB_ROOT_PW=$MYSQL_ROOT_PASSWORD
	fi
    else
        BACKUP_DB_ROOT_PW=$MARIADB_ROOT_PASSWORD
    fi
fi

mariadb-dump -u root --password=$BACKUP_DB_ROOT_PW $BACKUP_DB_NAME | gzip > "/backup/backup-db-"$BACKUP_DB_NAME"-"$BACKUP_DATE".sql.gz"
BACKUP_DATE_PRINT=$(date +"%Y-%m-%d %H:%M")
echo "$BACKUP_DATE_PRINT => Backed up database" 
