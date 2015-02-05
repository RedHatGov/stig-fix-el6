#!/bin/bash

## (GEN004900: CAT II) (Previously – G141) The SA will ensure the ftpusers 
## file contains the usernames of users not allowed to use FTP, and contains, 
## at a minimum, the system pseudo-users usernames and root.
echo '==================================================='
echo ' Patching GEN004900: Add system users to ftpusers'
echo '==================================================='
echo -n > /etc/ftpusers
for NAME in `cut -d: -f1 /etc/passwd`; do
	NAMEID=`id -u $NAME`
	if [ $NAMEID -lt 500 ]; then
		echo $NAME >> /etc/ftpusers
	fi
done;
