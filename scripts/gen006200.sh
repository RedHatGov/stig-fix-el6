#!/bin/bash

## (GEN006200: CAT II) (Previously – L057) The SA will configure permissions 
## for smbpasswd to 600, or more restrictive.
echo '==================================================='
echo ' Patching GEN006200: Set permissions for smbpasswd'
echo '==================================================='
if [ -e /usr/bin/smbpasswd ]; then
	chmod 600 /usr/bin/smbpasswd
fi
