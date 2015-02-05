#!/bin/sh

## (GEN001180: CAT II) (Previously - G036) All network services 
## daemon files must have mode 0755 or less permissive.
echo '==================================================='
echo ' Patching GEN001180: Network Service Permissions'
echo '==================================================='

for FILE in `find /usr/sbin/ -type f -perm +022`; do
  if [ -e "$FILE" ]; then
    # Pull the actual permissions
    PERMS=`stat -L --format='%04a' $FILE`

    # Break the actual file octal permissions up per entity
     FILESPECIAL=${PERMS:0:1}
     FILEOWNER=${PERMS:1:1}
     FILEGROUP=${PERMS:2:1}
     FILEOTHER=${PERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7022)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]; then
        chmod u-s,g-ws,o-wt $FILE
    fi
  fi
done

# Note: Some SUID/GUID bits will be removed that might break some things.
# Here is the default list from RHEL 5.7:
#-rws--x--x /usrs/bin/userhelper
#-rwxr-sr-x /usr/sbin/sendmail.sendmail
#-rwxr-sr-x /usr/sbin/lockdev
#-rwsr-xr-x /usr/sbin/userisdnctl
#-r-s--x--- /usr/sbin/suexec
#-rwsr-xr-x /usr/sbin/ccreds_validate
#-rwsr-xr-x /usr/sbin/usernetctl
