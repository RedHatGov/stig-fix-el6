#!/bin/bash

## (GEN006520: CAT II) (Previously – G189) The SA will ensure security tools
## and databases have permissions of 740, or more restrictive.
echo '==================================================='
echo ' Patching GEN006520: Set security tool and database'
echo '                     permissions'
echo '==================================================='
chmod 740 /etc/rc.d/init.d/iptables
chmod 740 /sbin/iptables
