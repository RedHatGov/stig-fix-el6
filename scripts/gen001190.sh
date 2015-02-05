#!/bin/sh
echo '==================================================='
echo ' Patching GEN001190: Remove ACLs /usr/sbin'
echo '==================================================='

for FILE in `find /usr/sbin/ ! -type l`; do
	if [ -e "$FILE" ]; then
    		ACL=`getfacl --skip-base $FILE 2>/dev/null`;
    		if [ "$ACL" != "" ]; then
      			setfacl --remove-all $FILE
   		fi
  	fi
done
