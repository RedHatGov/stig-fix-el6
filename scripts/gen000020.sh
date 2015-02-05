#!/bin/sh

## (GEN000020: CAT II) (Previously – G001) The IAO and SA will ensure, if
## configurable, the UNIX host is configured to require a password for access
## to single-user and maintenance modes.
echo '==================================================='
echo ' Patching GEN000020: Configuring Password for'
echo '                     single-user and maintenance'
echo '                     modes.'
echo '==================================================='

`/bin/grep sulogin /etc/inittab | /bin/grep -q wait`
if [ $? -gt 0 ]; then
	echo "" >> /etc/inittab
	echo "#Require password in single-user mode" >> /etc/inittab
	echo "~~:S:wait:/sbin/sulogin" >> /etc/inittab
fi

`/bin/grep SINGLE /etc/sysconfig/init | /bin/grep -q sulogin`
if [ $? -gt 0 ]; then
	sed -i "/PROMPT/s/yes/no/" /etc/sysconfig/init
	sed -i "/SINGLE/s/sushell/sulogin/" /etc/sysconfig/init
fi
