#!/bin/bash

## (GEN003200: CAT II) (Previously – G620) The SA will ensure the cron.deny 
## file has permissions of 600, or more restrictive. 
echo '==================================================='
echo ' Patching GEN003200: Seting cron.deny permissions'
echo '==================================================='
chmod 600 /etc/cron.deny
