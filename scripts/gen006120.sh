#!/bin/bash

## (GEN006120: CAT II) (Previously – L051) The SA will ensure the group owner 
## of the /etc/samba/smb.conf file is root.
echo '==================================================='
echo ' Patching GEN006120: Set group owner of smb.conf'
echo '==================================================='
if [ -e /etc/samba/smb.conf ]; then
	chgrp root /etc/samba/smb.conf
fi
