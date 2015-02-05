#!/bin/sh

## (GEN000440: CAT II) (Previously – G012) The SA will ensure all logon attempts (both
## successful and unsuccessful) are logged to a system log file.
echo '==================================================='
echo ' Patching GEN000440: Ensure Athentication Logged'
echo '==================================================='

/bin/grep "auth\.\*" /etc/syslog.conf | /bin/grep -q authlog &>/dev/null
if [ $? -gt 0 ]; then
cat >> /etc/syslog.conf << EOF 
# Added for DISA GEN000440 - Log Authentication Attepmts
auth.*			/var/log/authlog
EOF
fi
