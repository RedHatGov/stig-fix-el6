#!/bin/bash

## (GEN003140: CAT II) (Previously – G208) The SA will ensure the group owner 
## of the cron and crontab directories is root, sys, or bin.
echo '==================================================='
echo ' Patching GEN003140: Set group grper of cron'
echo '                     directories'
echo '==================================================='
chgrp root /etc/cron.hourly
chgrp root /etc/cron.daily
chgrp root /etc/cron.weekly
chgrp root /etc/cron.monthly
chgrp root /etc/cron.d
chgrp root /var/spool/cron
chgrp root /etc/crontab
chgrp root /etc/anacrontab
