#!/bin/bash

## (GEN003660: CAT II) The SA will ensure the authentication notice and
## informational data is logged.
echo '==================================================='
echo ' Patching GEN003660: Log autentication notice and'
echo '                     informational data'
echo '==================================================='
`/bin/grep auth.notice /etc/syslog.conf | /bin/grep -q messages`
if [ $? -gt 0 ]; then
cat >> /etc/syslog.conf << EOF 
# Added for DISA GEN003660 - Log Authentication and Informational Data
auth.notice		/var/log/messages
EOF
fi
