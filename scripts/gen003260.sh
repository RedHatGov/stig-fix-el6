#!/bin/bash

## (GEN003260: CAT II) (Previously – G623) The SA will ensure the owner and 
## group owner of the cron.deny file is root.
echo '==================================================='
echo ' Patching GEN003260: Set owner and group owner of'
echo '                     the cron.deny file'
echo '==================================================='
chown root:root /etc/cron.deny
