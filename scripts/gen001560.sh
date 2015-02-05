#!/bin/bash

## (GEN001560: CAT II) (Previously – G068) The user, application developers,
## and the SA will ensure user files and directories will have an initial
## permission no more permissive than 700, and never more permissive than 750.
echo '==================================================='
echo ' Patching GEN001560: Set home dir permissions'
echo '==================================================='
for BASEDIR  in "/home/* /root"
do
	find $BASEDIR -type f -exec chmod 600 '{}' \;
	find $BASEDIR -type d -exec chmod 700 '{}' \;
done
