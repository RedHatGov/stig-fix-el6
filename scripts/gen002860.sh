#!/bin/bash

## (GEN002860: CAT II) (Previously – G674) The SA and/or IAO will ensure old
## audit logs are closed and new audit logs are started daily.
echo '==================================================='
echo ' Patching GEN002860: Rotate audit logs daily'
echo '==================================================='
cat <<EOF > /etc/logrotate.d/audit 
/var/log/audit/audit.log {
	daily
	notifempty
	missingok
	postrotate
	/sbin/service auditd restart 2> /dev/null > /dev/null || true
	endscript
}
EOF
