#!/bin/bash

## (GEN003180: CAT II) (Previously – G210) The SA will ensure cron logs have 
## permissions of 600, or more restrictive.
echo '==================================================='
echo ' Patching GEN003180: Set cron log permissions'
echo '==================================================='
chmod 600 /var/log/cron
