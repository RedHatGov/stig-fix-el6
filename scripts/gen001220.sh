#!/bin/sh

## (GEN001220: CAT II) (Previously - G044) The SA will ensure the
## owner of all system files, programs, and directories is a system
## account.
echo '==================================================='
echo ' Patching GEN001220: System Command Ownership'
echo '==================================================='

# Check that the user belongs to a system account(UID<500)
function is_system_user {
   CURUSER=$1
   for SYSUSER in `awk -F ':' '{if($3 < 500) print $1}' /etc/passwd`; do
     if [ "$SYSUSER" = "$CURUSER" ]; then
       return 0
     fi
   done
   return 1
}

# Lets go through all of the files and if they are not owned by an account
# with a uid < 500, make the owner root.
for CHKDIR in '/etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin'; do
  if [ -d "$CHKDIR" ]; then
    for FILENAME in `find $CHKDIR ! -type l`; do
      if [ -e "$FILENAME" ]; then
        CUROWN=`stat -c %U $FILENAME`;
        is_system_user $CUROWN
        if [ $? -ne 0 ]; then
          chown root $FILENAME
        fi
      fi
    done
  fi
done
