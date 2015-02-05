#!/bin/bash

## (GEN003100: CAT II) (Previously – G206) The SA will ensure cron and crontab 
## directories have permissions of 755, or more restrictive.
echo '==================================================='
echo ' Patching GEN003100: Set crontab directory'
echo '                     permissions'
echo '==================================================='
chmod 700 /etc/cron.hourly
chmod 700 /etc/cron.daily
chmod 700 /etc/cron.weekly
chmod 700 /etc/cron.monthly
chmod 700 /etc/cron.d
chmod 700 /var/spool/cron
