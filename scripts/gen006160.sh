#!/bin/bash

## (GEN006160: CAT II) (Previously – L054) The SA will ensure the owner of 
## smbpasswd is root.
echo '==================================================='
echo ' Patching GEN006160: Set owner of smbpasswd'
echo '==================================================='
if [ -e /usr/bin/smbpasswd ]; then
	chown root /usr/bin/smbpasswd
fi
