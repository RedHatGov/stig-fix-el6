#!/bin/sh

## (GEN0000960: CATII) (Previously - G025) The SA will ensure the
## root search PATH (and the search path of root capable accounts)
## do not contain directories or files that are world writeable.
echo '==================================================='
echo ' Patching GEN000960: PATH Directory Permissions'
echo '==================================================='

PATHDIRS=`echo $PATH | sed "s/:/ /g"`

for DIR in $PATHDIRS; do
	if [ -d "$DIR" ]; then
      		find -H $DIR -maxdepth 1 -type f -perm /0002 -exec chmod o-w {} \;
    	fi
done
