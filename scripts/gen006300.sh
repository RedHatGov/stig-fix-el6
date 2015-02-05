#!/bin/bash

## (GEN006300: CAT II) (Previously – L158) The SA will ensure the 
## /etc/news/nnrp.access file has permissions of 600, or more restrictive.
echo '==================================================='
echo ' Patching GEN006300: Set nnrp.access permissions'
echo '==================================================='
if [ -e /etc/news/nnrp.access ]; then
	chmod 600 /etc/news/nnrp.access
fi
