#!/bin/bash

## (GEN003700: CAT II) The SA will ensure inetd (xinetd for Linux) is disabled
## if all inetd/xinetd based services are disabled.
echo '==================================================='
echo ' Patching GEN003700: Turn off unneeded services'
echo '==================================================='

/sbin/chkconfig --list | grep -q xinetd
if [ $? -eq 0 ]; then
	/sbin/chkconfig xinetd off
	/sbin/service xinetd stop &> /dev/null
fi
