#!/bin/bash

## (GEN006280: CAT II) (Previously – L156) The SA will ensure the 
## /etc/news/hosts.nntp.nolimit file has permissions of 600, or more 
## restrictive.
echo '==================================================='
echo ' Patching GEN006280: Set hosts.nnt.nolimit'
echo '                     permissions'
echo '==================================================='
if [ -e /etc/news/hosts.nntp.nolimit ]; then
	chmod 600 /etc/news/hosts.nntp.nolimit
fi
