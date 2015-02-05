#!/bin/bash

## (GEN006180: CAT II) (Previously – L055) The SA will ensure group owner of 
## smbpasswd is root.
echo '==================================================='
echo ' Patching GEN006180: Set group owner of smbpasswd'
echo '==================================================='
if [ -e /usr/bin/smbpasswd ]; then
	chgrp root /usr/bin/smbpasswd
fi
