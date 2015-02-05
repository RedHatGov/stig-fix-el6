#!/bin/bash

PDI=GEN001373
	
#Start-Lockdown
if [ -a "/etc/nsswitch.conf" ]; then
	echo '==================================================='
	echo ' Patching GEN001373: /etc/nsswitch.conf Permissions'
	echo '==================================================='
	# Pull the actual permissions
	FILEPERMS=`stat -L --format='%04a' /etc/nsswitch.conf`

	# Break the actual file octal permissions up per entity
	FILESPECIAL=${FILEPERMS:0:1}
	FILEOWNER=${FILEPERMS:1:1}
	FILEGROUP=${FILEPERMS:2:1}
	FILEOTHER=${FILEPERMS:3:1}

	# Run check by 'and'ing the unwanted mask(7133)
	if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]; then
		chmod u-xs,g-wxs,o-wxt /etc/nsswitch.conf
	fi
fi
