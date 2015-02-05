#!/bin/bash

## (GEN006320: CAT II) (Previously – L160) The SA will ensure the 
## /etc/news/passwd.nntp file has permissions of 600, or more restrictive.
echo '==================================================='
echo ' Patching GEN006320: Set passwd.nntp permissions'
echo '==================================================='
if [ -e /etc/news/passwd.nntp ]; then
	chmod 600 /etc/news/passwd.nntp
fi
