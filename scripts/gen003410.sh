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
#Group ID (Vulid): V-22395
#Group Title: GEN003410
#Rule ID: SV-26564r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003410
#Rule Title: The "at" directory must not have an extended ACL.
#
#Vulnerability Discussion: If the "at" directory has an extended ACL, unauthorized users could be allowed to view or to edit files containing sensitive information within the "at" directory. Unauthorized modifications could result in denial of service to authorized "at" jobs.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions of the file.
# ls -lLd /var/spool/cron/atjobs /var/spool/atjobs
#If the permissions include a '+', the file has an extended ACL, this is a finding.
#
#Fix Text: Remove the extended ACL from the file.
# setfacl --remove-all /var/spool/cron/atjobs /var/spool/atjobs   
#######################DISA INFORMATION###############################

echo '==================================================='
echo ' Patching GEN003410: Remove ACLs from AT Daemon'
echo '==================================================='

#Global Variables#
PDI=GEN003410

#Start-Lockdown
for ATFILE in /var/spool/cron/atjobs /var/spool/atjobs /var/spool/at; do
	if [ -a "$ATFILE" ]; then
		ACLOUT=`getfacl --skip-base $ATFILE 2>/dev/null`;
		if [ "$ACLOUT" != "" ]; then
			setfacl --remove-all $ATFILE
		fi
	fi
done
