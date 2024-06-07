#!/bin/bash

# if /config/config does not exist, copy it from /root/config
if [ ! -f /config/config ]; then
  cp /root/config.template /config/config
fi

# if /config/gitlfspull.sh does not exist, copy it from /root/gitlfspull.sh
if [ ! -f /config/gitlfspull.sh ]; then
  cp /root/gitlfspull.sh.template /config/gitlfspull.sh
  chmod 754 /config/gitlfspull.sh
fi

# Read the config file and set the interval
source /config/config

# Start the service that checks the volume for a script to run
while true; do
  if [ -f /config/gitlfspull.sh ]; then
    bash /config/gitlfspull.sh
  fi
  sleep $interval
done
