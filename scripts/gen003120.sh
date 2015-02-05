#!/bin/bash

## (GEN003120: CAT II) (Previously – G207) The SA will ensure the owner of the 
## cron and crontab directories is root or bin.
echo '==================================================='
echo ' Patching GEN003120: Set owner of cron directories'
echo '==================================================='
chown root /etc/cron.hourly
chown root /etc/cron.daily
chown root /etc/cron.weekly
chown root /etc/cron.monthly
chown root /etc/cron.d
chown root /var/spool/cron
chown root /etc/crontab
chown root /etc/anacrontab
