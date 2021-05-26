#Gibbon in Docker

## What this setup does
The Dockerfiles in php and webserver create minimal images with apache, configured for php-fpm, and php-fpm to enable gibbon to run.

docker-compose.yml assumes there is an additional reverse proxy - in this case [jwilder/nginx-proxy]{https://hub.docker.com/r/jwilder/nginx-proxy}, either running in one container or running nginx and docker-gen separated, on the network "webfront".
It further assumes there is an external network "backup" for accessing the database to create backups i.e. with [Bareos in Docker]{https://github.com/barcus/bareos}.

If you migrate your database put your databasedump in ./db/initdb before the first time you run docker-compose up -d. Adjustments to the database, like migration to another URL have to be done by you either in advance in the dump or via SQL using the mysql client.


## What you have to do

1. Clone the repo
2. Adjust the networking setup
..1. either 
..1.1. docker network create webfront
..1.2. docker network create backup
..1.3. and setup jwilder/nginx-proxy
..1.4 don't forget to add the network webfront to nginx-proxy 
..1.5 if you plan on using it in production add [letsencrypt-nginx-proxy-companion]{https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion}
..2. or remove remove docker-compose.yml and rename docker-compose.simple.yml to docker-compose.yml
..3. or edit docker-compose.yml to use another proxy like traefik.
3. copy example.env to .env
4. change the values to match your domain, and LOCALE
5. change the values for the passwords
6. run docker-compose pull
7. run docker-compose build
8. run docker-compose up -d
9. visit your server the way you set it up either via a domain name or if you use the simple setup via ip:80 and start the Gibbon setup

## Backupstrategy
As mentioned above a separate backup network is created for using backup software like Bareos to backup the database.
The volume where your gibbon data resides should also be backed up. Since I use a docker volume I tend to mount it in a bareos filedaemon container and use bareos.

Another option would be to use a directory on your host to mount into $GIBBON\_BASEDIR and any backup mechanism for your docker host system.
Backupscripts, and scripts for backup rotation are also added to the database container and executed by the crontab container. So you find your databasebackups under ./db/backup.

Therefore you should be fine using tar, rsync, borg or any other tool on those two directories.

## Feedback
Since it seems that Gibbon is not the right tool for my usecase, I will not be able to work on this setup in the future. Feel free to fork it, run it, use it or republish it. If you have any questions concerning Gibbon make sure to read the [documentation]{https://docs.gibbonedu.org/} use the [Gibbon forum]{https://ask.gibbonedu.org/} and get envolved with the project.
