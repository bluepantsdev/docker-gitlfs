#!/bin/bash

# check for /config directory
if [ ! -d /config ]; then
    echo "ERROR: /config directory not found"
    exit 1
fi

# check for /config/config file
if [ ! -f /config/config ]; then
    echo "NOTICE: /config/config file not found"
    echo "Copying /root/config.template to /config/config"
    cp /root/config.template /config/config
fi

# check for /config/_cron.sh file
if [ ! -f /config/_cron.sh ]; then
    echo "NOTICE: /config/_cron.sh file not found"
    echo "Copying /root/_cron.sh to /config/_cron.sh"
    cp /root/_cron.sh /config/_cron.sh
fi

# check for /config/gitlfspull.sh file
if [ ! -f /config/gitlfspull.sh ]; then
    echo "NOTICE: /config/gitlfspull.sh file not found"
    echo "Copying /root/gitlfspull.sh to /config/gitlfspull.sh"
    cp /root/gitlfspull.sh /config/gitlfspull.sh
    chmod +x /config/gitlfspull.sh
fi

# check for /data directory
if [ ! -d /data ]; then
    echo "ERROR: /data directory not found"
    exit 1
fi

# Source interval from /config/config provide a default if not found
source /config/config
if [ -z "$interval" ]; then
    echo "NOTICE: interval not found in /config/config"
    INTERVAL=1440
  else
    INTERVAL=$interval
fi

# Update OnUnitActiveSec in gitlfspull.timer
sed -i "s/OnUnitActiveSec=.*/OnUnitActiveSec=${INTERVAL}m/" /etc/systemd/system/gitlfspull.timer

# Reload systemd, enable and start gitlfspull.timer
systemctl daemon-reload
systemctl enable gitlfspull.timer
systemctl start gitlfspull.timer