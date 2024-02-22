#!/bin bash

LOCAL_PROJECT=${PWD##*/}

docker compose down

docker volume rm ${LOCAL_PROJECT}_gibbon-db-data
docker volume rm ${LOCAL_PROJECT}_gibbon-db-log
docker volume rm ${LOCAL_PROJECT}_gibbon-root
docker volume rm ${LOCAL_PROJECT}_gibbon-php-sessions

docker compose build
docker compose up -d
docker compose logs -f
