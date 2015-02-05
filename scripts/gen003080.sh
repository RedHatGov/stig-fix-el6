#!/bin/sh

## (GEN003080: CAT II) (Previously – G205) The SA will ensure crontabs have
## permissions of 600, or more restrictive, (700 for some Linux crontabs, which
## is detailed in the UNIX Checklist).
echo '==================================================='
echo ' Patching GEN003080: Cron File Permissions'
echo '==================================================='
chmod -R 700 /etc/cron.daily
chmod -R 700 /etc/cron.hourly
chmod -R 700 /etc/cron.weekly
chmod -R 700 /etc/cron.monthly
chmod 600 /etc/crontab
chmod 600 /etc/anacrontab
chmod -R 600 /etc/cron.d
chmod -R 600 /var/spool/cron
