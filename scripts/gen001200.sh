#!/bin/sh

## (GEN001200: CAT II)(Previously - G044) The SA will ensure
## all system commands have permissions of 755, or more restrictive
echo '==================================================='
echo ' Patching GEN001200: System Command Permissions'
echo '==================================================='

for CHKDIR in '/etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin'; do
  if [ -d "$CHKDIR" ]; then
    for FILENAME in `find $CHKDIR ! -type l`; do
      if [ -e "$FILENAME" ]; then
        # Pull the actual permissions
        FILEPERMS=`stat -L --format='%04a' $FILENAME`

        # Break the actual file octal permissions up per entity
        FILESPECIAL=${FILEPERMS:0:1}
        FILEOWNER=${FILEPERMS:1:1}
        FILEGROUP=${FILEPERMS:2:1}
        FILEOTHER=${FILEPERMS:3:1}

        # Run check by 'and'ing the unwanted mask(7022)
	# Note: The permissions say 0755, but if you remove the SUID/GUID bits
	# from many commands such as sudo or su, you could lock yourself out ir break
	# the system. This may need more discussion later on. For now, I'm removing
	# the check for the SUID/GUID and only removing write from group and other if needed.
	#        if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]

        if [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]; then
          #chmod u-s,g-ws,o-wt $FILENAME
          chmod g-w,o-w $FILENAME
        fi

      fi
    done
  fi
done
