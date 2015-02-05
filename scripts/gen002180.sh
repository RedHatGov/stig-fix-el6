#!/bin/bash

## (GEN002180: CAT II) (Previously – G073) The SA will ensure no shell has the 
## sgid bit set.
echo '==================================================='
echo ' Patching GEN002180: No shells have sgid bit set'
echo '==================================================='
for SHELL in `cat /etc/shells`; do
	chmod g-s $SHELL
done
