#!/bin/sh

## (GEN001260: CAT II) (Previously – G037) The SA will ensure all system log
## files have permissions of 640, or more restrictive.
echo '==================================================='
echo ' Patching GEN001260: Setting permissions of system'
echo '                     log files.'
echo '==================================================='
find /var/log/ -type f -exec chmod 640 '{}' \;
sed -i "s/chmod 0664/chmod 0640/" /etc/rc.d/rc.sysinit
