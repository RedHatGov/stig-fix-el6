#!/bin/sh

## (GEN000580: CAT II) (Previously – G019) The IAO will ensure all passwords contain 14
## characters (set in config/login.defs) - Ensuring 12 characters minimum due to fact
## that some organizations/agencies have shorter passwords with higher complexity.
## SRG RHEL-06-000050
echo '==================================================='
echo ' Patching GEN000580: Set minimum Password length.'
echo '==================================================='
if [ $(/bin/grep PASS_MIN_LEN /etc/login.defs | tail -1 | awk '{ print $2 }') -lt 12 ]; then
	sed -i "s/PASS_MIN_LEN[ \t]*[0-9]*/PASS_MIN_LEN\t14/" /etc/login.defs
fi
