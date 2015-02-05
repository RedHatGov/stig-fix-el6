#!/bin/sh

## (GEN001140: CAT II) (Previously - G034 System files and 
## directories must not have uneven access permissions
echo '==================================================='
echo ' Patching GEN001140: System File Permissions'
echo '==================================================='

for CHKDIR in /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
do
  if [ -d "$CHKDIR" ]; then
    for FILENAME in `find $CHKDIR`; do
      if [ -e "$FILENAME" ]; then
        # Pull the actual permissions
        FILEPERMS=`stat -L --format='%04a' $FILENAME`

        # Break the actual octal permissions up per entity
        FILESPECIAL=${FILEPERMS:0:1}
        FILEOWNER=${FILEPERMS:1:1}
        FILEGROUP=${FILEPERMS:2:1}
        FILEOTHER=${FILEPERMS:3:1}

        # If 'read' is NOT set on the owner and set on 'group' turn it off
        if [ $(($FILEOWNER&4)) -eq 0 -a $((FILEGROUP&4)) -ne 0 ]; then
          chmod g-r $FILENAME
        fi

        # If 'read' is NOT set on the owner and set on 'other' turn it off
        if [ $(($FILEOWNER&4)) -eq 0 -a $((FILEOTHER&4)) -ne 0 ]; then
          chmod o-r $FILENAME
        fi

        # If 'write' is NOT set on the owner and set on 'group' turn it off
        if [ $(($FILEOWNER&2)) -eq 0 -a $((FILEGROUP&2)) -ne 0 ]; then
          chmod g-w $FILENAME
        fi

        # If 'write' is NOT set on the owner and set on 'other' turn it off
        if [ $(($FILEOWNER&2)) -eq 0 -a $((FILEOTHER&2)) -ne 0 ]; then
          chmod o-w $FILENAME
        fi

        # If 'exec' is NOT set on the owner and set on 'group' turn it off
        if [ $(($FILEOWNER&1)) -eq 0 -a $((FILEGROUP&1)) -ne 0 ]; then
          chmod g-x $FILENAME
        fi

        # If 'exec' is NOT set on the owner and set on 'other' turn it off
        if [ $(($FILEOWNER&1)) -eq 0 -a $((FILEOTHER&1)) -ne 0 ]; then
          chmod o-x $FILENAME
        fi

      fi
    done
  fi
done
