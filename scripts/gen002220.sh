#!/bin/bash

## (GEN002220: CAT II) (Previously – G075) The SA will ensure all shells
## (excluding /dev/null and sdshell) have permissions of 755, or more
## restrictive.
echo '==================================================='
echo ' Patching GEN002220: Set shell permissions'
echo '==================================================='
for SHELL in `cat /etc/shells`; do
	chmod 755 $SHELL
done
