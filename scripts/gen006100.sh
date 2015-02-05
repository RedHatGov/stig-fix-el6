#!/bin/bash

## (GEN006100: CAT II) (Previously – L050) The SA will ensure the owner of 
## the/etc/samba/smb.conf file is root.
echo '==================================================='
echo ' Patching GEN006100: Set owner of smb.conf'
echo '==================================================='
if [ -e /etc/samba/smb.conf ]; then
	chown root /etc/samba/smb.conf
fi
