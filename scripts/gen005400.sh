#!/bin/sh

## (GEN005400: CAT II) (Previously – G656) The SA will ensure the owner of the
## /etc/syslog.conf file is root with permissions of 640, or more restrictive.
echo '==================================================='
echo ' Patching GEN005400: Set syslog.conf permissions'
echo '==================================================='
chown root /etc/syslog.conf
chmod 640 /etc/syslog.conf
