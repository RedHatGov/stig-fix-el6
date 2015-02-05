#!/bin/bash

## (LNX00220: CAT II) (Previously – L080) The SA will ensure the lilo.conf 
## file has permissions of 600 or more restrictive.
echo '==================================================='
echo ' Patching LNX00220: Set lilo.conf permissions'
echo '==================================================='
if [ -f /etc/lilo.conf ]; then
	chmod 600 /etc/lilo.conf
fi
