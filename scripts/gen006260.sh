#!/bin/bash

## (GEN006260: CAT II) (Previously – L154) The SA will ensure the 
## /etc/news/hosts.nntp file has permissions of 600, or more restrictive.
echo '==================================================='
echo ' Patching GEN006260: Set hosts.nntp permissions'
echo '==================================================='
if [ -e /etc/news/hosts.nntp ]; then
	chmod 600 /etc/news/hosts.nntp
fi
