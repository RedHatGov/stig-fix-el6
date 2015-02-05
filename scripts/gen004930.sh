#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
# 
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 05-Feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22444
#Group Title: The ftpusers file ownership
#Rule ID: SV-26704r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN004930
#Rule Title: The ftpusers file must be group-owned by root, bin, sys, or system.
#
#Vulnerability Discussion: If the ftpusers file is not group-owned by root or a system group, an unauthorized user may modify the file to allow unauthorized accounts to use FTP.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the ftpusers file.
#
#Procedure:
# ls -lL /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers
#
#If the file is not group-owned by root, bin, sys, or system, this is a finding.
#
#Fix Text: Change the group-owner of the ftpusers file.
#
#Procedure:
# chgrp root /etc/ftpusers /etc/vsftpd.ftpusers /etc/vsftpd/ftpusers   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN004930

#Start-Lockdown
if [[ -e /etc/vsftpd/ftpusers || -e /etc/vsftpd.ftpusers || -e /etc/ftpusers ]]; then
	echo '==================================================='
	echo ' Patching GEN004930: ftpusers Ownership'
	echo '==================================================='

	for FTPFILE in /etc/vsftpd/ftpusers /etc/vsftpd.ftpusers /etc/ftpusers; do
		if [ -a "$FTPFILE" ]; then
    			CURGROUP=`stat -c %G $FTPFILE`;
	    		if [  "$CURGROUP" != "root" -a "$CURGROUP" != "bin" -a "$CURGROUP" != "sys" -a "$CURGROUP" != "system" ]; then
				chgrp root $FTPFILE
    			fi
		fi
	done
fi
