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
#Group ID (Vulid): V-22397
#Group Title: GEN003470
#Rule ID: SV-26569r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003470
#Rule Title: The at.allow file must be group-owned by root, bin, sys, or cron.
#
#Vulnerability Discussion: If the group-owner of the at.allow file is not set to root, bin, sys, or cron, unauthorized users could be allowed to view or edit the list of users permitted to run "at" jobs. Unauthorized modification could result in denial of service to authorized "at" users or provide unauthorized users with the ability to run "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the file.
#
#Procedure:
# ls -lL /etc/at.allow
#
#If the file is not group-owned by root, bin, sys, or cron, this is a finding.
#
#Fix Text: Change the group ownership of the file.
#
#Procedure:
# chgrp root /etc/at.allow
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003470

#Start-Lockdown
if [ -e "/etc/at.allow" ]; then
	echo '==================================================='
	echo ' Patching GEN003470: /etc/at.allow Group Ownership'
	echo '==================================================='
	CURGOWN=`stat -c %G /etc/at.allow`;
	if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]; then
		chgrp root /etc/at.allow
	fi
fi
