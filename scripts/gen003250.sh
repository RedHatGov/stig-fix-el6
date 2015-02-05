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
# on 31-jan-2012 to check group ownership before running chgrp.
#  - updated by Vincent Passaro vincent.passaro@fotisnetworks.com
# 13 Feb 2012  Fixed PDI variable

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22391
#Group Title: GEN003250
#Rule ID: SV-26552r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003250
#Rule Title: The cron.allow file must be group-owned by root, bin, sys, or cron.
#
#Vulnerability Discussion: If the group of the cron.allow is not set to root, bin, sys or cron, the possibility exists for an unauthorized user to view or edit the list of users permitted to use cron. Unauthorized modification of this file could cause denial of service to authorized cron users or provide unauthorized users with the ability to run cron jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the file.
#
#Procedure:
# ls -lL /etc/cron.allow
#
#If the file is not group-owned by root, bin, sys, or cron, this is a finding.
#
#Fix Text: Change the group ownership of the file.
#
#Procedure:
# chgrp root /etc/cron.allow
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003250

#Start-Lockdown
if [ -e "/etc/cron.allow" ]; then
	echo '==================================================='
	echo ' Patching GEN003250: /etc/cron.allow Group Ownership'
	echo '==================================================='
	CURGOWN=`stat -c %G /etc/cron.allow`;

	if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "cron" ]; then
		chgrp root /etc/cron.allow
	fi
fi
