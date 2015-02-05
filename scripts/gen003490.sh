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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 02-feb-2012 to check group ownership before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22398
#Group Title: GEN003490
#Rule ID: SV-26572r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003490
#Rule Title: The at.deny file must be group-owned by root, bin, sys, or cron.
#
#Vulnerability Discussion: If the group-owner of the at.deny file is not set to root, bin, sys, or cron, unauthorized users could be allowed to view or edit sensitive information contained within the file. Unauthorized modification could result in denial of service to authorized "at" users or provide unauthorized users with the ability to run "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the file.
#
#Procedure:
# ls -lL /etc/at.deny
#
#If the file is not group-owned by root, bin, sys, or cron, this is a finding.
##
#Fix Text: Change the group ownership of the at.deny file to root, sys, bin, or cron.
#
#Procedure:
# chgrp root /etc/at.deny 
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003490

#Start-Lockdown
if [ -e "/etc/at.deny" ]; then
	echo '==================================================='
	echo ' Patching GEN003490: /etc/at.deny Group Ownership'
	echo '==================================================='
	CURGOWN=`stat -c %G /etc/at.deny`;

	if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]; then
		chgrp root /etc/at.deny
	fi
fi
