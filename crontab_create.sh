#!/bin/bash

PROJECT=${PWD##*/}
CONFIGFILE=config.json

sed "s/PROJECTNAME/${PROJECT}/g" ./crontab/config.json.template > ./crontab/$CONFIGFILE
