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
# on 02-jan-2011 to add content and move from dev to prod.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22396
#Group Title: GEN003430
#Rule ID: SV-26568r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003430
#Rule Title: The "at" directory must be group-owned by root, bin, sys, or cron.
#
#Vulnerability Discussion: If the group of the "at" directory is not root, bin, sys, or cron, unauthorized users could be allowed to view or edit files containing sensitive information within the directory.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the group ownership of the file.
#
#Procedure:
# ls -lL /var/spool/cron/atjobs /var/spool/atjobs
#
#If the file is not group-owned by root, bin, sys, or cron, this is a finding.
#
#Fix Text: Change the group ownership of the file to root, bin, sys, or cron.
#
#Procedure:
# chgrp <root or other system group> <"at" directory>   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003430: AT Daemon Group Ownership'
echo '==================================================='

#Global Variables#
PDI=GEN003430

#Start-Lockdown
for ATFILE in /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at; do
	if [ -a "$ATFILE" ]; then
		CURGOWN=`stat -c %G $ATFILE`;
		if [ "$CURGOWN" != "root" -a "$CURGOWN" != "sys" -a "$CURGOWN" != "bin" -a "$CURGOWN" != "daemon" -a "$CURGOWN" != "system" -a "$CURGOWN" != "cron" ]; then
			chgrp daemon $ATFILE
		fi
	  fi
done
