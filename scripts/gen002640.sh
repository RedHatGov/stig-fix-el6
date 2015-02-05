#!/bin/bash

## (GEN002640: CAT II) (Previously – G092) The SA will ensure logon capability 
## to default system accounts (e.g., bin, lib, uucp, news, sys, guest, daemon, 
## and any default account not normally logged onto) will be disabled by 
## making the default shell /bin/false, /usr/bin/false, /sbin/false, 
## /sbin/nologin, or /dev/null, and by locking the password.
echo '==================================================='
echo ' Patching GEN002640: Lock default system accounts'
echo '==================================================='
for NAME in `cut -d: -f1 /etc/passwd`; do
	NAMEID=`id -u $NAME`
	if [ $NAMEID -lt 500 -a $NAME != 'root' -a $NAME != 'oracle' -a $NAME != 'postgres' ]; then
     		/usr/sbin/usermod -L -s /sbin/nologin $NAME
     	fi
done
