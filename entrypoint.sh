#!/bin/bash

interval=86400

# if /config/config does not exist, copy it from /root/config
if [ ! -f /config/config ]; then
  cp /root/config.template /config/config
fi

# if /config/gitlfspull.sh does not exist, copy it from /root/gitlfspull.sh
if [ ! -f /config/gitlfspull.sh ]; then
  cp /root/gitlfspull.sh /config/gitlfspull.sh
  chmod 754 /config/gitlfspull.sh
fi

# if /config/_cron.sh.inc does not exist, copy it from /root/_cron.sh.inc
if [ ! -f /config/_cron.sh ]; then
  cp /root/_cron.sh /config/_cron.sh
  chmod 754 /config/_cron.sh
fi

# Read the config file and set the interval
source /config/config

# echo the environment variable
echo "Tag: $RUN_TAG"

# Start the service that checks the volume for a script to run
while true; do
  if [ -f /config/gitlfspull.sh ]; then
    bash /config/gitlfspull.sh
  fi
  sleep $interval
done
