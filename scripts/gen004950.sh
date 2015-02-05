#!/bin/bash

#######################DISA INFORMATION###############################
## Severity: CAT II
## Rule Version (STIG-ID): GEN004950 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004950

if [[ -e /etc/vsftpd/ftpusers || -e /etc/vsftpd.ftpusers || -e /etc/ftpusers ]]; then
	echo '==================================================='
	echo ' Patching GEN004950: Remove ACLs from ftpusers'
	echo '==================================================='
	for FTPFILE in /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers; do
		if [ -a "$FTPFILE" ]; then
			ACLOUT=`getfacl --skip-base $FTPFILE 2>/dev/null`;
			if [ "$ACLOUT" != "" ]; then
				setfacl --remove-all $FTPFILE
			fi
		fi
	done
fi
