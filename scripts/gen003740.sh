#!/bin/sh

## (GEN003740: CAT II) (Previously – G108) The SA will ensure the inetd.conf
## (xinetd.conf for Linux) file has permissions of 440, or more restrictive.
## The Linux xinetd.d directory will have permissions of 755, or more
## restrictive. This is to include any directories defined in the includedir
## parameter.
echo '==================================================='
echo ' Patching GEN003740: Set permissions for xinetd'
echo '                     configuration files.'
echo '==================================================='
if [ -e /etc/xinetd.d ]; then
	chmod 755 /etc/xinetd.d
fi

if [ -e /etc/xinetd.conf ]; then
	chmod 440 /etc/xinetd.conf
fi
