#!/bin/sh

## (GEN002560: CAT II) (Previously – G089) The SA will ensure the system and
## user umask is 077.
echo '==================================================='
echo ' Patching GEN002560: Set default umask.'
echo '==================================================='
`grep umask /etc/bashrc | grep -q 077`
if [ $? -gt 0 ]; then
	sed -i "/umask/ c\umask 077" /etc/bashrc
fi

`grep umask /etc/csh.cshrc | grep -q 077`
if [ $? -gt 0 ]; then
	sed -i "/umask/ c\umask 077" /etc/csh.cshrc
fi

`grep umask /etc/profile | grep -q 077`
if [ $? -gt 0 ]; then
	sed -i "/umask/ c\umask 077" /etc/profile
fi

`grep umask /etc/init.d/functions | grep -q 027`
if [ $? -gt 0 ]; then
	sed -i "/umask/ c\umask 027" /etc/init.d/functions
fi
