#!/bin/sh

## (GEN001240: CAT II) (Previously - G046) The SA will ensure the
## group owner of all system files, programs, and directories is a
## system group.
echo '==================================================='
echo ' Patching GEN001240: System Group Ownership'
echo '==================================================='

# Check that the group belongs to a system group(GID<500)
function is_system_group {
	CURGROUP=$1
	for SYSGROUP in `awk -F ':' '{if($3 < 500) print $1}' /etc/group`; do
		if [ "$SYSGROUP" = "$CURGROUP" ]; then
			return 0
		fi
	done
	return 1
}

# Lets go through all of the files and if they are not owned by a group
# with a gid < 500, make the group-owner root.
for CHKDIR in '/etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin'; do
	if [ -d "$CHKDIR" ];  then
		for FILENAME in `find $CHKDIR ! -type l`; do
			if [ -e "$FILENAME" ]; then
				CURGROUP=`stat -c %G $FILENAME`;
				is_system_group $CURGROUP
				if [ $? -ne 0 ]; then
					chgrp root $FILENAME
				fi
      			fi
		done
	fi
done
