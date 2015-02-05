#!/bin/bash

## (GEN003060: CAT II) The SA will ensure default system accounts (with the
## possible exception of root) will not be listed in the cron.allow file. If
## there is only a cron.deny file, the default accounts (with the possible
## exception of root) will be listed there.
echo '==================================================='
echo ' Patching GEN003060: Limit default account cron'
echo '                     abilities'
echo '==================================================='
echo 'root' > /etc/cron.allow
awk -F: '{print $1}' /etc/passwd | grep -v root > /etc/cron.deny
